import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_background_service_ios/flutter_background_service_ios.dart';
import 'package:get/get.dart';
import 'package:soup/utils/root.dart';

import 'controllers/bindings/main_binding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeService();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark));

    return GetMaterialApp(
        builder: (context, child) => Scaffold(
              // 화면 클릭 시, 키보드 숨기기
              body: GestureDetector(
                onTap: () {
                  hideKeyboard(context);
                },
                child: child,
              ),
            ),
        initialBinding: MainBinding(),
        home: Root());
  }

  void hideKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }
}

Future<void> initializeService() async {
  final service = FlutterBackgroundService();
  await service.configure(
    androidConfiguration: AndroidConfiguration(
      // this will executed when app is in foreground or background in separated isolate
      onStart: onStart,

      // auto start service
      autoStart: true,
      isForegroundMode: true,
    ),
    iosConfiguration: IosConfiguration(
      // auto start service
      autoStart: true,

      // this will executed when app is in foreground in separated isolate
      onForeground: onStart,

      // you have to enable background fetch capability on xcode project
      onBackground: onIosBackground,
    ),
  );
}

// to ensure this executed
// run app from xcode, then from xcode menu, select Simulate Background Fetch
void onIosBackground() {
  WidgetsFlutterBinding.ensureInitialized();
  int i = 0;
  Timer.periodic(Duration(seconds: 5), (timer) {
    print("Test $i");
    i++;
  });
}

void onStart() {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isIOS) FlutterBackgroundServiceIOS.registerWith();
  if (Platform.isAndroid) FlutterBackgroundServiceAndroid.registerWith();

  final service = FlutterBackgroundService();

  service.onDataReceived.listen((event) {
    if (event!["action"] == "setAsForeground") {
      service.setAsForegroundService();
      return;
    }

    if (event["action"] == "setAsBackground") {
      service.setAsBackgroundService();
    }

    if (event["action"] == "stopService") {
      service.stopService();
    }
  });

  // bring to foreground
  service.setAsForegroundService();
  Timer.periodic(const Duration(seconds: 1), (timer) async {
    if (!(await service.isRunning())) timer.cancel();
    service.setNotificationInfo(
      title: "투자 진행중입니다...",
      content: "Updated at ${DateTime.now()}",
    );

    service.sendData(
      {
        "current_date": DateTime.now().toIso8601String(),
      },
    );
  });
}
