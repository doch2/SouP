import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart' hide Response;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:soup/controllers/user_controller.dart';
import 'package:soup/models/user.dart';
import 'package:soup/services/firestore_database.dart';

class AuthController extends GetxController {
  FirebaseAuth authInstance = FirebaseAuth.instance;

  Rxn<User> _firebaseUser = Rxn<User>();
  User? get user => _firebaseUser.value;
  Map loginUserInfo = {}; //userID, email, name
  RxString selectGroupName = "init".obs;

  RxBool isLogin = false.obs;

  final Dio _dio = Get.find<Dio>();


  @override
  onInit() async {
    _firebaseUser.bindStream(authInstance.authStateChanges());
    _firebaseUser.value = authInstance.currentUser;
    if (user != null) { Get.find<UserController>().user = await FirestoreDatabase().getUser(user!.uid); }
  }

  void signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
    await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    UserCredential _authResult = await FirebaseAuth.instance.signInWithCredential(credential);

    loginUserInfo["userid"] = _authResult.user?.uid;
    loginUserInfo["email"] = googleUser?.email;
    loginUserInfo["name"] = googleUser?.displayName;

    writeAccountInfo();
    isLogin.value = true;
  }

  void logOut() async {
    try {
      await authInstance.signOut();

      Get.find<UserController>().clear();

      isLogin.value = false;

      Fluttertoast.showToast(
          msg: "로그아웃 되었습니다.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(0xE6FFFFFF),
          textColor: Colors.black,
          fontSize: 13.0
      );
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        "로그아웃 오류",
        e.message ?? "예기치 못한 오류가 발생하였습니다.",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void writeAccountInfo() async {
    UserModel _user = UserModel(
      id: loginUserInfo["userid"],
      email: loginUserInfo["email"],
      name: loginUserInfo["name"],
    );

    await FirebaseFirestore.instance
        .collection("users")
        .doc(loginUserInfo["userid"])
        .get()
        .then((doc) async {
      if (doc.exists) {
        print("User info is already exist");
      } else {
        await FirestoreDatabase().createNewUser(_user);
      }
    }
    );

    Get.find<UserController>().user = _user;
  }
}
