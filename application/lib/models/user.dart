import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id;
  String? name;
  String? email;
  bool? isTradeOn;
  Map? tradeSetting;

  UserModel(
      {this.id, this.name, this.email, this.isTradeOn, this.tradeSetting});

  UserModel.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
    id = documentSnapshot.id;
    name = documentSnapshot["name"];
    email = documentSnapshot["email"];
    isTradeOn = documentSnapshot["isTradeOn"];
    tradeSetting = documentSnapshot["tradeSetting"];
  }
}

class UserInformation {
  String? userTardyAmount;
  String? purchaseAmount;
  String? evaluateValue;
  String? gainOrLoss;

  UserInformation({
    this.userTardyAmount,
    this.purchaseAmount,
    this.evaluateValue,
    this.gainOrLoss,
  });

  UserInformation.fromJson({required json}) {
    userTardyAmount = json["sunamt"];
    purchaseAmount = json["mamt"];
    evaluateValue = json["tappamt"];
    gainOrLoss = json["tdtsunik"];
  }
}
