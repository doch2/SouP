import '../services/api_reference.dart';

enum StockOrderType {
  /// 매수
  buy,
  /// 매도
  sell
}

enum StockOrderQuoteType {
  /// 시장가
  marketOrder,
  /// 지정가
  limitOrder,
  /// 조건부지정가
  conditionalOrder,
  /// 시간외종가
  afterHourClosingPriceOrder,
  /// 시간외단일가
  afterHourSinglePriceOrder,
}

extension StockOrderTypeExtension on StockOrderType {
  String get convertStr {
    switch (this) {
      case StockOrderType.buy: return "2";
      case StockOrderType.sell: return "1";
      default: return "";
    }
  }
}

extension StockOrderQuoteTypeExtension on StockOrderQuoteType {
  String get convertStr {
    switch (this) {
      case StockOrderQuoteType.marketOrder: return "03@";
      case StockOrderQuoteType.limitOrder: return "00@";
      case StockOrderQuoteType.conditionalOrder: return "05@";
      case StockOrderQuoteType.afterHourClosingPriceOrder: return "81@";
      case StockOrderQuoteType.afterHourSinglePriceOrder: return "82@";
      default: return "";
    }
  }
}



class OrderStockRequestData {
  String _apiUrl = ApiReference().xingAPIUrl;

  late String _accountNum;
  late int _inptPwd;
  late String _ticker;
  late int _amount;
  late int _price;
  late StockOrderType _BnsTpCode;
  late StockOrderQuoteType _OrdprcPtnCode;

  String get accountNum => _accountNum;
  int get inptPwd => _inptPwd;
  String get ticker => _ticker;
  int get amount => _amount;
  int get price => _price;
  StockOrderType get BnsToCode => _BnsTpCode;
  StockOrderQuoteType get OrdprcPtnCode => _OrdprcPtnCode;


  OrderStockRequestData({
    required String accountNum,
    required int inptPwd,
    required String ticker,
    required int amount,
    required int price,
    required StockOrderType BnsTpCode,
    required StockOrderQuoteType OrdprcPtnCode,}){
    _accountNum = accountNum;
    _inptPwd = inptPwd;
    _ticker = ticker;
    _amount = amount;
    _price = price;
    _BnsTpCode = BnsTpCode;
    _OrdprcPtnCode = OrdprcPtnCode;
  }

  Map toJson() {
    Map result = {
      "body": {
        "trName": "CSPAT00600",
        "bNext": false,
        "query": {
          "AcntNo": _accountNum,
          "InptPwd": _inptPwd.toString(),
          "IsuNo": ticker,
          "OrdQty": amount.toString(),
          "OrdPrc": price.toString(),
          "BnsTpCode": _BnsTpCode.convertStr,
          "OrdprcPtnCode": _OrdprcPtnCode.convertStr,
          "MgntrnCode": "000",
          "LoanDt": "",
          "OrdCndiTpCode": "0"
        }
      },
      "header": {
        "uuid": "452c9d0f-e91f-47d4-9600-616651d16f7f"
      },
      "firstValue": "",
      "_links": {
        "self": {
          "href": "$_apiUrl/ebest/request-messages/CSPAT00600"
        },
        "request": {
          "href": "$_apiUrl/ebest/queries"
        }
      }
    };

    return result;
  }
}

class GetAccountStockBalanceRequestData {
  String _apiUrl = ApiReference().xingAPIUrl;

  late String _accountNum;
  late int _inptPwd;

  String get accountNum => _accountNum;
  int get inptPwd => _inptPwd;


  GetAccountStockBalanceRequestData({
    required String accountNum,
    required int inptPwd,}){
    _accountNum = accountNum;
    _inptPwd = inptPwd;
  }

  Map toJson() {
    Map result = {
      "body": {
        "trName": "t0424",
        "bNext": false,
        "query": {
          "accno": _accountNum,
          "passwd": _inptPwd.toString(),
          "prcgb": "",
          "chegb": "",
          "dangb": "",
          "charge": "",
          "cts_expcode": ""
        }
      },
      "header": {
        "uuid": "2dc17c3c-3d34-4575-8870-058142143b5c"
      },
      "firstValue": "",
      "_links": {
        "self": {
          "href": "$_apiUrl/ebest/request-messages/t0424"
        },
        "request": {
          "href": "$_apiUrl/ebest/queries"
        }
      }
    };

    return result;
  }
}