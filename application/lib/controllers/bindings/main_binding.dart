import 'package:soup/controllers/stock_controller.dart';
import 'package:soup/controllers/user_controller.dart';
import 'package:soup/controllers/auth_controller.dart';
import 'package:soup/controllers/trade_controller.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Dio());

    Get.put<UserController>(UserController(), permanent: true);
    Get.put<AuthController>(AuthController(), permanent: true);

    Get.put<TradeController>(TradeController());
    Get.put<StockController>(StockController());
  }
}
