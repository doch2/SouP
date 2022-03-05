class StockModel {
  String? stockId; //주식에 접근할 수 있는 종목코드
  String? name;

  StockModel({this.stockId, this.name});

  StockModel.fromJson({Json}) {
    stockId = Json["stockId"];
    name = Json["name"];
  }
}
