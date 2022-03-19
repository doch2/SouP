import 'dart:async';

import 'package:get/get.dart';
import 'package:yahoofin/yahoofin.dart';

class StockController extends GetxController with StateMixin {
  final yfin = YahooFin();

  //StockChart chart;
  //StockHistory hist;
  RxString ticker = "".obs;
  RxBool isRealtime = false.obs;

  Rx<StockInfo> info = Rx(StockInfo());
  Rx<StockQuote> price = Rx(StockQuote());

  Timer? timer;
  RxInt i = 0.obs; //Test Variable

  @override
  void onInit() async {
    super.onInit();
  }

  getStock() async {
    change(null, status: RxStatus.loading());
    String symbol = ticker + ".KS";

    (await yfin.checkSymbol(symbol)) ? null : symbol = ticker + ".KQ";

    info.value = yfin.getStockInfo(ticker: symbol);

    price.value = await yfin.getPrice(stockInfo: info.value);
    change(null, status: RxStatus.success());
  }

  getRealtimeStock() {
    print(isRealtime.value);

    if (isRealtime.value == false) {
      print("Start");

      isRealtime.value = true;

      timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
        print("GO");
        price.value = await yfin.getPrice(stockInfo: info.value);
        i.value++;
      });
    } else {
      print("Stop");
      isRealtime.value = false;
      timer!.cancel();
      i.value = 0;
    }
  }
}
