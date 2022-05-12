import 'dart:async';
import 'package:get/get.dart';

class LifeCycleController extends SuperController {
  @override
  void onDetached() {}

  @override
  void onInactive() {
    Timer.periodic(const Duration(seconds: 5), (timer) {
      print("Current : ${DateTime.now()}");
    });
  }

  @override
  void onPaused() {}

  @override
  void onResumed() {}
}
