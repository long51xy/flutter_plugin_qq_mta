import 'package:flutter/material.dart';
import 'package:qq_mta/qq_mta.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final QqMta _qqMta = QqMta();

  @override
  void initState() {
    super.initState();

    _qqMta.init(debugEnabled: true, iosAppKey: "I82RGZ8IP2JL");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: SizedBox(
            height: 150,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RaisedButton(
                  onPressed: () {
                    _qqMta.trackEvent("test");
                  },
                  child: Text("trackEvent test"),
                ),
                RaisedButton(
                  onPressed: () {
                    _qqMta
                        .trackEvent("test2", parameters: {'a': 'a', 'b': 'b'});
                  },
                  child: Text("trackEvent 带参数"),
                ),
                RaisedButton(
                  onPressed: () async {
                    bool isVPNOn = await _qqMta.isVPNOn();
                    print(isVPNOn);
                  },
                  child: Text("isVPNOn"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
