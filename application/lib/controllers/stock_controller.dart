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

  getStock() async {
    change(null, status: RxStatus.loading());
    String symbol = ticker + ".KS";

    (await yfin.checkSymbol(symbol)) ? null : symbol = ticker + ".KQ";

    info.value = yfin.getStockInfo(ticker: symbol);
    price.value = await yfin.getPrice(stockInfo: info.value);

    final res = info.value.res;
    final body = json.decode(res.body);

    stockInform.value = StockInformation.fromJson(body: body);

    change(null, status: RxStatus.success());
  }

  String getCurrentState(String state) {
    if (state == "CLOSED") {
      return "장이 마감되었습니다";
    } else if (state == "REGULAR") {
      return "현재 매매거래가 가능한 시간입니다";
    } else if (state == "PRE") {
      return "현재 장외거래가 가능한 시간입니다. (프리)";
    } else if (state == "POST") {
      return "현재 장외거래가 가능한 시간입니다. (애프터)";
    } else {
      return "정보를 불러오지 못했습니다.";
    }

    //POST,PRE는 해외주식에만?
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
