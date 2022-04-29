import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soup/controllers/stock_controller.dart';
import 'package:soup/models/stock.dart';
import 'package:soup/themes/text_theme.dart';

class StockList extends StatelessWidget {
  final double width;
  final double height;
  final List<StockModel> list;
  final bool recommanded;
  StockList(
      {Key? key,
      required this.height,
      required this.width,
      required this.list,
      this.recommanded = true})
      : super(key: key);

  StockController controller = Get.find<StockController>();

  Widget _stockData(String name, String stockId) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          controller.moveStockData(name, stockId);
        },
        child: Row(
          children: [
            const Icon(Icons.abc),
            Text(
              "${name}",
              style: homeNormal,
            )
          ],
        ),
      ),
    );
  }

  Widget _longerStockList() {
    ScrollController _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.position.pixels) {}
    });

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.back(),
        child: const Icon(Icons.backspace),
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: list.length,
        itemBuilder: (conetext, int i) =>
            _stockData(list[i].name!, list[i].stockId!),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: SizedBox(
          width: width * 0.8,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Center(
                  child: Text(
                    recommanded ? "오늘자 추천 종목" : "현재 투자한 주식 종목",
                    style: homeUserName,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Builder(builder: (context) {
                  List<Widget> children = [];

                  int flag = list.isEmpty ? 0 : 5;

                  for (int i = 0; i < flag; i++) {
                    children.add(_stockData(list[i].name!, list[i].stockId!));
                  }

                  children.add(InkWell(
                    child: const Text(
                      "더보기",
                      style: homeNormal,
                    ),
                    onTap: () {
                      Get.dialog(_longerStockList());
                    },
                  ));

                  return Column(
                    children: children,
                  );
                })
              ],
            ),
          ),
        ));
  }
}
