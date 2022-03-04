import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:soup/controllers/auth_controller.dart';
import 'package:soup/controllers/user_controller.dart';
import 'package:soup/models/user.dart';

class FirestoreDatabase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final UserController userController = Get.find<UserController>();

  Future<bool> createNewUser(UserModel user) async {
    try {
      await _firestore.collection("users").doc(user.id).set({
        "name": user.name,
        "email": user.email,
        "isTradeOn": user.isTradeOn,
        "tradeSetting": user.tradeSetting
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<UserModel> getUser(String? uid) async {
    try {
      DocumentSnapshot _doc =
          await _firestore.collection("users").doc(uid).get();
      return UserModel?.fromDocumentSnapshot(documentSnapshot: _doc);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  setUserTradeStatus(bool isTradeOn) async {
    try {
      await _firestore.collection("users").doc(Get.find<AuthController>().user?.uid).update({
        "isTradeOn": isTradeOn,
      });

    } catch (e) {
      print(e);
      rethrow;
    }
  }

  setUserTradeSetting(Map newSetting) async {
    try {
      await _firestore.collection("users").doc(Get.find<AuthController>().user?.uid).update({
        "tradeSetting": newSetting,
      });

    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
