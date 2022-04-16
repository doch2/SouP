import 'dart:async';
import 'package:get/get.dart';
import 'package:soup/controllers/user_controller.dart';

class LifeCycleController extends SuperController {
  @override
  void onDetached() {}

  @override
  void onInactive() {
    Timer.periodic(const Duration(seconds: 5), (timer) {
      final userController = Get.find<UserController>();
      print(userController.user.isTradeOn.toString());
      print(userController.user.id.toString());
      print(userController.user.email.toString());
    });
  }

  @override
  void onPaused() {}

  @override
  void onResumed() {}
}
