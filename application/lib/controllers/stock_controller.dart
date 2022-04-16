import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:soup/models/stock.dart';
import 'package:yahoofin/yahoofin.dart';

class StockController extends GetxController with StateMixin {
  final yfin = YahooFin();

  //StockChart chart;
  //StockHistory hist;
  RxString ticker = "".obs;
  RxBool isRealtime = false.obs;

  Rx<StockInfo> info = Rx(StockInfo());
  Rx<StockQuote> price = Rx(StockQuote());
  Rx<StockInformation> stockInform = StockInformation().obs;

  Timer? timer;

  @override
  void onInit() async {
    super.onInit();
  }

  @override
  void onClose() async {
    super.onClose();
  }

  String getCurrentState() {
    if (stockInform.value.marketState == "CLOSED") {
      return "장이 마감되었습니다";
    } else if (stockInform.value.marketState == "REGULAR") {
      return "현재 매매거래가 가능한 시간입니다";
    } else if (stockInform.value.marketState == "PRE" ||
        stockInform.value.marketState == "PREPRE") {
      return "현재 장외거래가 가능한 시간입니다.";
    } else if (stockInform.value.marketState == "POST" ||
        stockInform.value.marketState == "POSTPOST") {
      return "현재 장외거래가 가능한 시간입니다.";
    } else {
      return "정보를 불러오지 못했습니다.";
    }
    //POST,PRE는 해외주식에만?
  }

  getStock() async {
    change(null, status: RxStatus.loading());
    String symbol = ticker + ".KS";
    (await yfin.checkSymbol(symbol)) ? null : symbol = ticker + ".KQ";
    info.value = yfin.getStockInfo(ticker: symbol);
    price.value = await yfin.getPrice(stockInfo: info.value);
    change(null, status: RxStatus.success());
  }

  getRealtimeStock() async {
    if (isRealtime.value == false) {
      isRealtime.value = true;
      timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
        final res = await http.get(Uri.parse(
            "https://query1.finance.yahoo.com/v7/finance/quote?symbols=${info.value.ticker}"));
        final body = json.decode(res.body);
        stockInform.update((val) {
          val!.marketPrice =
              body['quoteResponse']['result'][0]['regularMarketPrice'];
        });
      });
    } else {
      isRealtime.value = false;
      timer!.cancel();
    }
  }
}
