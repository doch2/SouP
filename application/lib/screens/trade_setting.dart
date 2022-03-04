import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:soup/controllers/trade_controller.dart';

import '../themes/color_theme.dart';
import '../themes/text_theme.dart';

class TradeSetting extends GetWidget<TradeController> {
  TradeSetting({Key? key}) : super(key: key);

  late double _height, _width;

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;


    return Scaffold(
      backgroundColor: blueOne,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(width: _width, height: _height),
            Positioned(
              top: _height * 0.15,
              left: _width * 0.1,
              child: Text("현재 매매 상황", style: tradeSettingNowStatusTitle),
            ),
            Positioned(
              top: _height * 0.15 + 25,
              left: _width * 0.1,
              child: Obx(() {
                bool isTrade = controller.userController.user.isTradeOn as bool;

                return Text(isTrade ? "자동매매 진행중" : "투자중이 아닙니다", style: tradeSettingNowStatus);
              }),
            ),
            Positioned(
              top: _height * 0.325,
              left: _width * 0.1,
              child: Row(
                children: [
                  Text("매매 사용하기", style: tradeSettingMenuTitle),
                  SizedBox(width: _width * 0.05),
                  FutureBuilder(
                      future: controller.checkUserTradeStatus(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return Obx(() => FlutterSwitch(
                            height: _height * 0.03,
                            width: _width * 0.12,
                            padding: 4.0,
                            toggleSize: _width * 0.04,
                            borderRadius: 16.0,
                            activeColor: blueThree,
                            value: controller.isTradeTurnOn.value,
                            onToggle: (value) => controller.isTradeTurnOn.value = value,
                          ));
                        } else if (snapshot.hasError) { //데이터를 정상적으로 불러오지 못했을 때
                          return Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(width: _width, height: _height * 0.4),
                              Center(child: Text("데이터를 정상적으로 불러오지 못했습니다. \n다시 시도해 주세요.", textAlign: TextAlign.center)),
                            ],
                          );
                        } else { //데이터를 불러오는 중
                          return Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(width: _width * 0.1, height: _height * 0.03),
                              Center(child: CircularProgressIndicator()),
                            ],
                          );
                        }
                      }
                  )
                ],
              ),
            ),
            Positioned(
              top: _height * 0.4,
              left: _width * 0.1,
              child: Row(
                children: [
                  Text("매매할 주식의 상승 정확도", style: tradeSettingMenuTitle),
                  getNumTextField("%", controller.accuracyPercentageTextController),
                  Text("이상", style: tradeSettingMenuTitle),
                ],
              ),
            ),
            Positioned(
              top: _height * 0.475,
              left: _width * 0.1,
              child: Row(
                children: [
                  getNumTextField("%", controller.tradePercentageTextController),
                  Text("이상 상승/하락 시 매도", style: tradeSettingMenuTitle),
                ],
              ),
            ),
            Positioned(
              top: _height * 0.55,
              left: _width * 0.1,
              child: Row(
                children: [
                  Text("분산 투자할 주식 개수", style: tradeSettingMenuTitle),
                  getNumTextField("입력", controller.stockAmountTextController),
                ],
              ),
            ),
            Positioned(
              top: _height * 0.65,
              left: _width * 0.1,
              child: Obx(() => Row(
                children: [
                  Text("매매 방식", style: tradeSettingMenuTitle),
                  SizedBox(width: _width * 0.04),
                  getChooseBox("시장가"),
                  SizedBox(width: _width * 0.03),
                  getChooseBox("일반가"),
                ],
              )),
            ),
            Positioned(
              bottom: _height * 0.15,
              child: GestureDetector(
                onTap: () => controller.storeTradeSetting(),
                child: Container(
                  width: _width * 0.45,
                  height: _height * 0.05,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10,
                        spreadRadius: 3,
                        color: blueTwo
                      )
                    ]
                  ),
                  child: Center(child: Text("설정 저장하기")),
                ),
              ),
            )
          ],
        )
      ),
    );
  }

  SizedBox getNumTextField(String hintText, TextEditingController textController) {
    return SizedBox(
      width: _width * 0.12,
      child: TextField(
        keyboardType: TextInputType.number,
        controller: textController,
        textAlign: TextAlign.center,
        style: tradeSettingMenuTextField,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: _height * 0.02),
          hintText: hintText,
        ),
      ),
    );
  }

  GestureDetector getChooseBox(String btnText) {
    bool isChoose = controller.isTradingMethod.value == btnText;

    return GestureDetector(
      onTap: () => controller.isTradingMethod.value = btnText,
      child: Container(
        width: _width * 0.125,
        height: _height * 0.04,
        decoration: BoxDecoration(
            color: isChoose ? blueThree : Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(40),
                blurRadius: 5,
                spreadRadius: 1,
              )
            ]
        ),
        child: Center(child: Text(btnText, style: TextStyle(color: isChoose ? Colors.white : Colors.black))),
      ),
    );
  }
}