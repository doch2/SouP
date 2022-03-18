import 'package:get/get.dart';
import 'package:yahoofin/yahoofin.dart';

class StockController extends GetxController with StateMixin {
  final yfin = YahooFin();

  //StockChart chart;
  //StockHistory hist;

  RxString ticker = "".obs;

  Rx<StockInfo> info = Rx(StockInfo());
  Rx<StockQuote> price = Rx(StockQuote());

  @override
  void onInit() async {
    change(null, status: RxStatus.loading());
    String symbol = ticker.value + ".KS";
    (await yfin.checkSymbol(symbol)) ? null : symbol = ticker.value + ".KQ";

    info.value = yfin.getStockInfo(ticker: symbol);
    price.value = await yfin.getPrice(stockInfo: info.value);
    change(null, status: RxStatus.success());
    super.onInit();
  }
}
