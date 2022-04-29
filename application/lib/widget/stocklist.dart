import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:soup/controllers/stock_controller.dart';
import 'package:soup/models/stock.dart';
import 'package:soup/screens/stock_page.dart';
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

                  for (int i = 0; i < 5; i++) {
                    children.add(Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          controller.getReady(list[i].name!, list[i].stockId!);
                        },
                        child: Row(
                          children: [
                            const Icon(Icons.abc),
                            Text(
                              "${list[i].name}",
                              style: const TextStyle(fontSize: 17),
                            )
                          ],
                        ),
                      ),
                    ));
                  }

                  children.add(Text("더보기"));

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
