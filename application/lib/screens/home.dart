import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:soup/controllers/user_controller.dart';
import 'package:soup/models/stock.dart';
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
            top: _height * 0.225,
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
          ),
          Positioned(
            top: _height * 0.325,
            left: _width * 0.1,
            child: recommandStock([
              StockModel(stockId: "005930", name: "삼성전자"),
              StockModel(stockId: "035720", name: "카카오"),
              StockModel(stockId: "247540", name: "에코프로비엠"),
              StockModel(stockId: "005380", name: "현대차"),
              StockModel(stockId: "089980", name: "상아프론테크"),
            ], context),
          )
        ],
      )),
    );
  }

  Widget recommandStock(List<StockModel> list, context) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          width: _width * 0.8,
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              children: [
                Center(
                  child: Text(
                    "오늘자 추천 종목",
                    style: homeUserName,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Builder(builder: (context) {
                  List<Widget> children = [];

                  for (int i = 0; i < list.length; i++) {
                    children.add(Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          _showToast("${list[i].name}(${list[i].stockId})로 이동");
                        },
                        child: Row(
                          children: [
                            Icon(Icons.abc),
                            Text(
                              "${list[i].name}",
                              style: TextStyle(fontSize: 17),
                            )
                          ],
                        ),
                      ),
                    ));
                  }

                  return Column(
                    children: children,
                  );
                })
              ],
            ),
          ),
        ));
  }

  _showToast(String content) => Fluttertoast.showToast(
      msg: content,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Color(0xE6FFFFFF),
      textColor: Colors.black,
      fontSize: 13.0);
}
