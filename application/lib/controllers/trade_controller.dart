import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:soup/controllers/auth_controller.dart';
import 'package:soup/controllers/user_controller.dart';
import 'package:soup/services/firestore_database.dart';

class TradeController extends GetxController {
  FirestoreDatabase _firestoreDatabase = FirestoreDatabase();
  final AuthController _authController = Get.find<AuthController>();
  final UserController userController = Get.find<UserController>();

  static const platform = MethodChannel('com.itlabxor.soup/xingapi');

  final accuracyPercentageTextController = TextEditingController();
  final tradePercentageTextController = TextEditingController();
  final stockAmountTextController = TextEditingController();

  final accuracyPercentagefocusnode = FocusNode();
  final tradePercentagefocusnode = FocusNode();
  final stockAmountfocusnode = FocusNode();
  final scroll = ScrollController();

  RxBool isTradeTurnOn = true.obs;
  RxString isTradingMethod = "".obs;

  void onInit() {
    stockAmountfocusnode.addListener(() {
      scroll.animateTo(
        -10000,
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      );
    });

    super.onInit();
  }

  void onClose() {
    super.onClose();
  }

  loginEbestStock() async {
    bool isSuccess = await platform.invokeMethod("loginEbestSign");
  }

  checkUserTradeStatus() async {
    bool? isAllow = userController.user.isTradeOn;
    isTradeTurnOn.value = isAllow!;

    return true;
  }

  storeTradeSetting() async {
    try {
      _firestoreDatabase.setUserTradeStatus(isTradeTurnOn.value);

      userController.user =
          await FirestoreDatabase().getUser(_authController.user?.uid);

      _showToast("저장에 성공하였습니다.");
    } catch (e) {
      _showToast("저장에 실패하였습니다.");
    }
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
