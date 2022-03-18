import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soup/controllers/stock_controller.dart';

class StockPage extends StatelessWidget {
  StockPage({Key? key}) : super(key: key);

  StockController controller = Get.find<StockController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        controller.obx(
            (state) => Text("${controller.info} : ${controller.price}"),
            onLoading: CircularProgressIndicator()),
        Row(
          children: [
            ElevatedButton(
              onPressed: () {},
              child: Text("구매"),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red)),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text("판매"),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue)),
            ),
          ],
        )
      ]),
    );
  }
}
