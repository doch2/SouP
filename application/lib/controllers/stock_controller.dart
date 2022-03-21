import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
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
  Rx<StockInformation> stockInform = Rx(StockInformation());

  Timer? timer;
  RxInt i = 0.obs; //Test Variable

  @override
  void onInit() async {
    super.onInit();
  }

  String getCurrentState() {
    if (stockInform.value.marketState == "CLOSED") {
      return "장이 마감되었습니다";
    } else if (stockInform.value.marketState == "REGULAR") {
      return "현재 매매거래가 가능한 시간입니다";
    } else if (stockInform.value.marketState == "PRE") {
      return "현재 장외거래가 가능한 시간입니다. (프리)";
    } else if (stockInform.value.marketState == "POST") {
      return "현재 장외거래가 가능한 시간입니다. (애프터)";
    } else {
      return "정보를 불러오지 못했습니다.";
    }
    //POST,PRE는 해외주식에만?
  }

  getStockInfo(String symbol) {
    info.value = yfin.getStockInfo(ticker: symbol);
    final res = info.value.res;
    final body = json.decode(res.body);
    stockInform.value = StockInformation.fromJson(body: body);
  }

  getStock() async {
    change(null, status: RxStatus.loading());
    String symbol = ticker + ".KS";
    (await yfin.checkSymbol(symbol)) ? null : symbol = ticker + ".KQ";
    getStockInfo(symbol);
    price.value = await yfin.getPrice(stockInfo: info.value);
    change(null, status: RxStatus.success());
  }

  getRealtimeStock() {
    if (isRealtime.value == false) {
      isRealtime.value = true;
      timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
        getStockInfo(info.value.ticker!);
        i.value++;
      });
    } else {
      isRealtime.value = false;
      timer!.cancel();
      i.value = 0;
    }
  }
}
