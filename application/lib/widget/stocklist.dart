import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soup/controllers/stock_controller.dart';
import 'package:soup/models/stock.dart';
import 'package:soup/themes/text_theme.dart';

class BaseStockList extends StatelessWidget {
  BaseStockList(
      {Key? key,
      required this.child,
      required this.width,
      this.title = "오늘자 추천 종목"})
      : super(key: key);
  final Widget child;
  final double width;
  String title;
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
                    title,
                    style: homeUserName,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                child
              ],
            ),
          ),
        ));
  }
}

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
        shrinkWrap: true,
        controller: _scrollController,
        itemCount: list.length,
        itemBuilder: (conetext, int i) =>
            _stockData(list[i].name!, list[i].stockId!),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseStockList(
        child: Builder(builder: (context) {
          List<Widget> children = [];

          int flag = list.isEmpty ? 0 : 5;

          for (int i = 0; i < flag; i++) {
            children.add(_stockData(list[i].name!, list[i].stockId!));
          }

          children.add(_stockData("서울식품", "004410"));

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
        }),
        width: width);
  }
}

class OwnedStockList extends StatelessWidget {
  final double width;
  final double height;
  final List<OwnedStock> list;
  OwnedStockList({
    Key? key,
    required this.height,
    required this.width,
    required this.list,
  }) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return BaseStockList(
      child: Builder(builder: (context) {
        List<Widget> children = [
          SizedBox(
            height: 36,
          )
        ];

        for (int i = 0; i < (list.length); i++) {
          children.add(Column(
            children: [
              _stockData(list[i].hname!, list[i].expcode!),
              Text("현재 가격 : ${list[i].price}", style: homeNormal),
              Text("매입 가격 : ${list[i].mamt}", style: homeNormal),
              Text("평가 가격 : ${list[i].appamt}", style: homeNormal),
              Text("수익율 : ${list[i].sunikrt}", style: homeNormal),
            ],
          ));
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: children,
        );
      }),
      width: width,
      title: "현재 투자한 주식 종목",
    );
  }
}
