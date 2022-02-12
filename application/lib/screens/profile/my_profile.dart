import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soup/controllers/auth_controller.dart';
import 'package:soup/controllers/user_controller.dart';

class MyProfile extends GetWidget<UserController> {
  MyProfile({Key? key}) : super(key: key);

  late double _height, _width;
  AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;


    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Text("Profile"),
            GestureDetector(onTap: () => authController.logOut(), child: Icon(Icons.logout))
          ],
        )
      ),
    );
  }
}