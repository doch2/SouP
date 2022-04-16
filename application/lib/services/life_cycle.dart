import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:soup/controllers/user_controller.dart';

class LifeCycleController extends SuperController {
  @override
  void onDetached() {
    // TODO: implement onDetached
  }

  @override
  void onInactive() {
    // TODO: implement onInactive
  }

  @override
  void onPaused() {
    Timer.periodic(Duration(seconds: 5), (timer) {
      final userController = Get.find<UserController>();
      print(userController.user.isTradeOn.toString());
    });

    // TODO: implement onPaused
  }

  @override
  void onResumed() {
    // TODO: implement onResumed
  }
}

_showToast(String content) => Fluttertoast.showToast(
    msg: content,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: const Color(0xE6FFFFFF),
    textColor: Colors.black,
    fontSize: 13.0);
