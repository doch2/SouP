import 'package:get/get.dart';
import 'package:yahoofin/yahoofin.dart';

class StockController extends GetxController with StateMixin {
  final yfin = YahooFin();

  //StockChart chart;
  //StockHistory hist;
  Rx<StockInfo> info = Rx(StockInfo());
  Rx<StockQuote> price = Rx(StockQuote());

  @override
  void onInit() async {
    super.onInit();
  }

  getStock(String ticker) async {
    change(null, status: RxStatus.loading());
    String symbol = ticker + ".KS";

    (await yfin.checkSymbol(symbol)) ? null : symbol = ticker + ".KQ";

    info.value = yfin.getStockInfo(ticker: symbol);

    price.value = await yfin.getPrice(stockInfo: info.value);
    change(null, status: RxStatus.success());
  }
}
