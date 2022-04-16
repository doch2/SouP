class StockModel {
  String? stockId; //주식에 접근할 수 있는 종목코드
  String? name;

  StockModel({this.stockId, this.name});

  StockModel.fromJson({json}) {
    stockId = json["stockId"];
    name = json["name"];
  }
}

class StockInformation {
  String? stockName;
  String? marketState;
  double? marketPrice;
  double? bid;
  double? ask;
  StockInformation(
      {this.stockName, this.marketState, this.marketPrice, this.bid, this.ask});

  StockInformation.fromJson({body}) {
    stockName = body['quoteResponse']['result'][0]['longName'];
    marketState = body['quoteResponse']['result'][0]['marketState'];
    marketPrice = body['quoteResponse']['result'][0]['regularMarketPrice'];
    bid = body['quoteResponse']['result'][0]['bid']; //주식 팔떄
    ask = body['quoteResponse']['result'][0]['ask']; //주식 살때
  }
}
