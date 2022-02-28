import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soup/controllers/user_controller.dart';
import 'package:soup/themes/color_theme.dart';
import 'package:soup/themes/text_theme.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  late double _height, _width;
  late UserController userController;

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;

    userController = Get.find<UserController>();


    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: BoxDecoration(color: blueOne),
              width: _width,
              height: _height,
            ),
            Positioned(
              bottom: -(_height * 0.075),
              child: Hero(
                tag: "bottomDesign",
                child: Image.asset(
                  "assets/images/background_cloud.png",
                  width: _width,
                ),
              ),
            ),
            Positioned(
              top: _height * 0.125,
              left: _width * 0.1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "안녕하세요!",
                    style: homeHello,
                  ),
                  Obx(() => Text(
                    "${userController.user.name}님",
                    style: homeUserName,
                  ))
                ],
              ),
            ),
            Positioned(
              top: _height * 0.275,
              left: _width * 0.1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "현재 서버 상태",
                    style: homeHello,
                  ),
                  Text(
                    "정상",
                    style: homeHello,
                  )
                ],
              ),
            )
          ],
        )
      ),
    );
  }
}