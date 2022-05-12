import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soup/controllers/auth_controller.dart';
import 'package:soup/controllers/user_controller.dart';
import 'package:soup/themes/text_theme.dart';
import 'package:soup/widget/bottomdesign.dart';
import 'package:soup/widget/stocklist.dart';

class MyProfile extends GetWidget<UserController> {
  MyProfile({Key? key}) : super(key: key);

  late double _height, _width;
  final AuthController authController = Get.find<AuthController>();
  final UserController userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;

    return Scaffold(
        body: SafeArea(
      child: RefreshIndicator(
        onRefresh: userController.refreshData,
        child: Stack(
          fit: StackFit.expand,
          children: [
            BottomDesign(width: _width, height: _height),
            Padding(
              padding: const EdgeInsets.all(24),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    footer(),
                    userInfo(),
                    getDeposit(),
                    _ownedStockList(_height, _width),
                  ],
                ),
              ),
            ),
          ],
        ),
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
          Text(
            "Logout",
            style: homeNormal,
          ),
          SizedBox(
            width: 10,
          ),
          Icon(Icons.logout)
        ],
      )),
    );
  }

  Widget userInfo() {
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
              "${authController.user!.displayName}",
              style: homeUserName,
            ),
            Text(
              "${authController.user!.email}",
              style: homeNormal,
            ),
          ],
        ),
      ],
    );
  }

  Widget getDeposit() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Text(
              "현재 예수금",
              style: homeUserName,
            ),
            userController.obx(
                (state) => Column(
                      children: [
                        Text(
                            "보유 금액 ${int.parse(userController.userInformation.value!.userTardyAmount!) - int.parse(userController.userInformation.value!.purchaseAmount!)}원",
                            style: homeNormal),
                        Text(
                            "현재 금액 ${userController.userInformation.value!.userTardyAmount}원",
                            style: homeNormal),
                        Text(
                            "매수 금액 ${userController.userInformation.value!.purchaseAmount}원",
                            style: homeNormal),
                        Text(
                            "평가 금액 ${userController.userInformation.value!.evaluateValue}원",
                            style: homeNormal),
                        Text(
                            "평가 손익 ${userController.userInformation.value!.gainOrLoss}원",
                            style: homeNormal),
                      ],
                    ),
                onLoading: const CircularProgressIndicator())
          ],
        ),
      ),
    );
  }

  Widget _ownedStockList(height, width) {
    return OwnedStockList(
        height: height, width: width, list: controller.ownedStockList.value);
  }
}
