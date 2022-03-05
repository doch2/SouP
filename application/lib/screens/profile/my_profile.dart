import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:soup/controllers/auth_controller.dart';
import 'package:soup/controllers/user_controller.dart';
import 'package:soup/models/stock.dart';
import 'package:soup/themes/text_theme.dart';

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
          Padding(
            padding: EdgeInsets.all(24),
            child: Column(children: [
              footer(),
              userInfo(authController),
              GetDeposit(),
              ownedStock([
                StockModel(stockId: "005930", name: "삼성전자"),
                StockModel(stockId: "035720", name: "카카오"),
                StockModel(stockId: "247540", name: "에코프로비엠"),
                StockModel(stockId: "005380", name: "현대차"),
                StockModel(stockId: "089980", name: "상아프론테크"),
              ], context),
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
        children: [
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
            CircleAvatar(
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

  Widget GetDeposit() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
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

  Widget ownedStock(List<StockModel> list, context) {
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
                    "현재 투자한 주식 종목",
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

  Widget bottomDesign() {
    return Column(
      children: [
        Image.asset(
          "assets/images/background_cloud.png",
          width: _width,
        ),
      ],
    );
  }
}
