import 'dart:collection';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:soup/models/stock.dart';

class RecommandController extends GetxController with StateMixin {
  Rx<List<StockModel>?> recommandedStock = Rx(null);
  dynamic stockName = {};

  @override
  void onInit() async {
    change(null, status: RxStatus.loading());
    await getStockName();
    getRecommandedStock();
    change(null, status: RxStatus.success());
    super.onInit();
  }

  Future<dynamic> getStockName() async {
    String jsonString =
        await rootBundle.loadString("assets/json/stock_name.json");
    final jsonResponse = json.decode(jsonString);
    stockName = jsonResponse;
  }

  Future getRecommandedStock() async {
    await FirebaseFirestore.instance
        .collection("stock-predict")
        .doc("202204")
        .get()
        .then((value) {
      Map<String, dynamic> data = value.data()!["22"];
      final sortedKeys = data.keys.toList(growable: false)
        ..sort((a, b) => data[b].compareTo(data[a]));
      LinkedHashMap sortedData = LinkedHashMap.fromIterable(sortedKeys,
          key: (k) => k, value: (k) => data[k]);
      recommandedStock.value = sortedData.entries
          .map(
              (e) => StockModel(name: stockName[e.key] ?? "뭐앵", stockId: e.key))
          .toList();
    });

    // final sortedMap = Map.fromEntries(
    //     json.entries.toList()..sort(((a, b) => a.value.compareTo(b.value))));

    // recommandedStock.value = sortedMap.entries
    //     .map((model) => StockModel(name: model.key, stockId: model.key))
    //     .toList();
  }
}
