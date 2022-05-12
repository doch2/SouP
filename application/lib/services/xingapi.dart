import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:soup/models/xingapi_request.dart';
import 'package:soup/services/api_reference.dart';

class XingAPI {
  late String accountStr;
  late String password;
  XingAPI({required this.accountStr, required this.password});

  final Dio _dio = Get.find<Dio>();
  String _apiUrl = ApiReference().xingAPIUrl;

  orderStock(String ticker, int amount, int price, StockOrderType orderType,
      StockOrderQuoteType quoteType) async {
    try {
      Response response = await _dio.post(
        "$_apiUrl/ebest/queries",
        options: Options(contentType: "application/json"),
        data: OrderStockRequestData(
          accountNum: accountStr,
          inptPwd: password,
          ticker: ticker,
          amount: amount,
          price: price,
          BnsTpCode: orderType,
          OrdprcPtnCode: quoteType,
        ).toJson(),
      );

      if (response.data['header']['bIsSystemError'] == '0') {
        return {
          "success": true,
          "content": response.data,
        };
      } else {
        return {
          "success": false,
          "content": response.data['header']['szMessage'],
        };
      }
    } on DioError catch (e) {
      return {
        "success": false,
        "content": e.response?.data['header']['szMessage'],
      };
    }
  }

  Future<Map<String, dynamic>> getAccountStockBalance() async {
    try {
      Response response = await _dio.post(
        "$_apiUrl/ebest/queries",
        options: Options(contentType: "application/json"),
        data: GetAccountStockBalanceRequestData(
          accountNum: accountStr,
          inptPwd: password,
        ).toJson(),
      );

      if (response.data['header']['bIsSystemError'] == '0') {
        return {
          "success": true,
          "content": response.data,
        };
      } else {
        return {
          "success": false,
          "content": response.data['header']['szMessage'],
        };
      }
    } on DioError catch (e) {
      return {
        "success": false,
        "content": e.response?.data['header']['szMessage'],
      };
    }
  }
}
