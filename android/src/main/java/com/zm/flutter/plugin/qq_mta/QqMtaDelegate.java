package com.zm.flutter.plugin.qq_mta;

import android.Manifest;
import android.app.Activity;
import android.content.Intent;
import android.content.pm.PackageManager;

import androidx.annotation.NonNull;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;

import com.tencent.stat.StatConfig;
import com.tencent.stat.StatService;

import org.json.JSONObject;

import java.util.Iterator;
import java.util.Map;
import java.util.Properties;

import io.flutter.Log;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;

public class QqMtaDelegate implements PluginRegistry.ActivityResultListener, ActivityCompat.OnRequestPermissionsResultCallback {
    private static final String ERROR_RESULT_CODE = "-1";
    public final static int REQUEST_READ_PHONE_STATE = 1;

    private final Activity activity;
    private MethodChannel.Result pendingResult;

    public QqMtaDelegate(Activity activity) {
        this.activity = activity;
    }

    void init(Map<String, Object> arguments, MethodChannel.Result result) {
        this.pendingResult = result;

        try {
            JSONObject options = new JSONObject(arguments);
            boolean debugEnable = options.optBoolean("debugEnable", false);
            int permissionCheck = ContextCompat.checkSelfPermission(this.activity, Manifest.permission.READ_PHONE_STATE);

            if (permissionCheck != PackageManager.PERMISSION_GRANTED) {
                ActivityCompat.requestPermissions(this.activity, new String[]{Manifest.permission.READ_PHONE_STATE}, REQUEST_READ_PHONE_STATE);
            } else {
                //TODO
            }

            StatConfig.setDebugEnable(debugEnable);
            // 基础统计API
            StatService.registerActivityLifecycleCallbacks(this.activity.getApplication());
            result.success("Tencent Analytics init succeed");
        } catch (Exception e) {
            Log.e("Tencent Analytics init exception", e.getMessage());
            e.printStackTrace();
            result.error(ERROR_RESULT_CODE, "Tencent Analytics init exception", e);
        }
    }

    void trackEvent(Map<String, Object> arguments, MethodChannel.Result result) {
        this.pendingResult = result;

        try {
            JSONObject options = new JSONObject(arguments);
            String eventName = options.getString("eventName");
            JSONObject parameters = options.optJSONObject("parameters");

            Properties prop = new Properties();
            if (parameters != null) {
                Iterator iterator = parameters.keys();
                while (iterator.hasNext()) {
                    String key = (String) iterator.next();
                    String value = parameters.getString(key);
                    prop.setProperty(key, value);
                }
            }

            StatService.trackCustomKVEvent(this.activity, eventName, prop);
            result.success("Tencent Analytics logEvent=[" + eventName + "] succeed");
        } catch (Exception e) {
            Log.e("Tencent Analytics trackEvent exception", e.getMessage());
            e.printStackTrace();
            result.error(ERROR_RESULT_CODE, "Tencent Analytics trackEvent exception", e);
        }
    }

    @Override
    public boolean onActivityResult(int requestCode, int resultCode, Intent data) {
        return false;
    }

    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
        switch (requestCode) {
            case REQUEST_READ_PHONE_STATE:
                if ((grantResults.length > 0) && (grantResults[0] == PackageManager.PERMISSION_GRANTED)) {
                    //TODO
                }
                break;

            default:
                break;
        }
    }
}
