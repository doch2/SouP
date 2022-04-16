import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soup/controllers/auth_controller.dart';
import 'package:soup/controllers/user_controller.dart';
import 'package:soup/models/stock.dart';
import 'package:soup/themes/text_theme.dart';
import 'package:soup/widget/bottomdesign.dart';
import 'package:soup/widget/stocklist.dart';

class MyProfile extends GetWidget<UserController> {
  MyProfile({Key? key}) : super(key: key);

  late double _height, _width;
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;

    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          BottomDesign(width: _width, height: _height),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(children: [
              footer(),
              userInfo(authController),
              getDeposit(),
              StockList(
                height: _height,
                width: _width,
                list: [
                  StockModel(stockId: "005930", name: "삼성전자"),
                  StockModel(stockId: "035720", name: "카카오"),
                  StockModel(stockId: "247540", name: "에코프로비엠"),
                  StockModel(stockId: "005380", name: "현대차"),
                  StockModel(stockId: "089980", name: "상아프론테크"),
                ],
                recommanded: false,
              ),
              Flexible(
                child: Container(),
              ),
            ]),
          ),
        ],
      ),
    ));
  }

  GestureDetector footer() {
    return GestureDetector(
      onTap: () => authController.logOut(),
      child: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: const [
          Text("Logout"),
          SizedBox(
            width: 10,
          ),
          Icon(Icons.logout)
        ],
      )),
    );
  }

  Widget userInfo(AuthController auth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CircleAvatar(
              child: FlutterLogo(size: 50),
              radius: 50,
            ),
            Text(
              "${auth.user!.displayName}",
              style: homeUserName,
            ),
            Text(
              "${auth.user!.email}",
              style: homeHello,
            ),
          ],
        ),
      ],
    );
  }

  Widget getDeposit() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: const [
          Text(
            "현재 예수금",
            style: homeUserName,
          ),
          Text(
            "1,000,000",
            style: homeHello,
          )
        ],
      ),
    );
  }
}
