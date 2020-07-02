# 腾讯统计 Flutter SDK 

# author

zhaolong<zhaoyuen123@126.com>

# Integration Steps

## Step 1: Add Dependency


```yaml
  qq_mta: 0.1.1
```

## Step 2: Add permissions (Android)

The mta SDK requires that you add the INTERNET permission in your `Android Manifest` file.

```xml
<!-- 必选权限< -->
<uses-permission android:name="android.permission.INTERNET"/>
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>
<uses-permission android:name="android.permission.ACCESS_WIFI_STATE"/>
<!-- 可选权限< -->
<uses-permission android:name="android.permission.READ_PHONE_STATE"/>
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
<uses-permission android:name="android.permission.WRITE_SETTINGS"/>
```
使用 AndroidStudio 在 /app/build.gradle 文件下添加以下内容
```gradle
android {
    ...
    defaultConfig{
      ...
      manifestPlaceholders = [
          //Android AppKey, 用于配置SDK
          MTA_APPKEY:"你的AppKey",
          //标注应用推广渠道用以区分新用户来源，可填写如应用宝，豌豆荚等
          MTA_CHANNEL:"渠道名称"
      ]
    }
}
```
## Step 3: IOS
pod install

## example

```dart
    final QqMta _qqMta = QqMta();

    // 生产请关闭debug
    _qqMta.init(debugEnabled: true);

    // 普通事件
    _qqMta.trackEvent("test");

    // 带参数事件
    _qqMta.trackEvent("test2", parameters:{'a':'a', 'b':'b'});

    /// 注意事件请先在腾讯统计后台导入事件和参数 要不收不到
``` 
## 常见问题
  解决:java.lang.NoClassDefFoundError: Failed resolution of: Lorg/apache/http/client/methods/HttpPost
  `https://blog.csdn.net/shanshan_1117/article/details/89952128`
  安卓9.0 Cleartext HTTP traffic to XXX not permitted问题
  `https://www.jianshu.com/p/fd0b0fd0e34c`
  上架AppStore 上传IDFA注意事项 https://mta.qq.com/docs/iOS_idfa.html

## doc
  官方文档:
    `https://mta.qq.com/docs/`