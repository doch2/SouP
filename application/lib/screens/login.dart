import 'package:soup/controllers/auth_controller.dart';
import 'package:soup/themes/color_theme.dart';
import 'package:soup/themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class Login extends GetWidget<AuthController> {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: blueOne,
      body: Center(
          child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: _width,
            height: _height,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("SouP", style: loginTitle),
              const Text("(Stock Prediction)", style: loginSubTitle),
              SizedBox(height: _height * 0.125),
              GestureDetector(
                onTap: () => {controller.signInWithGoogle()},
                child: Container(
                  width: _width * 0.842,
                  height: _height * 0.08,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                            color: grayShadowOne,
                            blurRadius: 10,
                            offset: Offset(0, -1)),
                        BoxShadow(
                            color: grayShadowOne,
                            blurRadius: 10,
                            offset: Offset(0, 5))
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: _width * 0.1),
                      SvgPicture.asset(
                        'assets/images/googleIcon.svg',
                        width: _width * 0.07,
                      ),
                      SizedBox(width: _width * 0.15),
                      const Text("구글로 로그인", style: loginBoxTitle)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      )),
    );
  }
}
