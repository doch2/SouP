import 'package:get/get.dart';

class TodayRecommandedStock {
  String? name;
  double? risingPercent;
  double? purchasedPrice;
  bool? hold;
}

Future<void> buyStock(String name, bool marketPrice, int stockCount) async {}

Future<void> sellStock(String name, int stockCount) async {}

class AutomaticSale extends GetxController {
  RxList<TodayRecommandedStock?> trs = RxList();
  Future<void> autoSale(
    double buyStockAccuarcy,
    bool marketPrice,
    int stockCount,
    int currentPrice,
    int sellPercent,
  ) async {
    trs.forEach((element) async {
      // 주식 상승 확률이 일정 값보다 높고 보유하고 있지 않을 때
      if (element!.risingPercent! > buyStockAccuarcy && !(element.hold!)) {
        await buyStock(element.name!, marketPrice, stockCount);
        element.hold = true;
      }
    });
    trs.forEach((element) async {
      if (element!.hold!) {
        if (currentPrice / element.purchasedPrice! * 100 >= sellPercent) {
          await sellStock(element.name!, stockCount);
          element.hold = false;
        }
      }
    });
  }
}
