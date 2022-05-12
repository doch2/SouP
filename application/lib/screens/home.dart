import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soup/controllers/recommand_controller.dart';
import 'package:soup/controllers/user_controller.dart';
import 'package:soup/themes/color_theme.dart';
import 'package:soup/themes/text_theme.dart';
import 'package:soup/widget/bottomdesign.dart';
import 'package:soup/widget/stocklist.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  late double _height, _width;
  late UserController userController;
  late RecommandController recommandController;

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;

    userController = Get.find<UserController>();
    recommandController = Get.find<RecommandController>();

    return Scaffold(
      body: Center(
          child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: const BoxDecoration(color: blueOne),
            width: _width,
            height: _height,
          ),
          BottomDesign(width: _width, height: _height),
          Positioned(
            top: _height * 0.125,
            left: _width * 0.1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
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
            top: _height * 0.225,
            left: _width * 0.1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
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
          ),
          Positioned(
              top: _height * 0.325,
              left: _width * 0.1,
              child: Obx(
                () => StockList(
                  height: _height,
                  width: _width,
                  list: recommandController.recommandedStock.value ?? [],
                  recommanded: true,
                ),
              )),
        ],
      )),
    );
  }
}
