import 'package:soup/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soup/controllers/auth_controller.dart';
import 'package:soup/screens/login.dart';

class Root extends GetWidget<AuthController> {
  const Root({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (controller.user?.uid != null) {
      controller.isLogin.value = true;
    }

    return Obx(
      () {
        if (controller.isLogin.value) {
          return const MainScreen();
        } else {
          return const Login();
        }
      },
    );
  }
}
