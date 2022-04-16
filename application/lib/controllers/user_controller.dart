import 'package:get/get.dart';
import 'package:soup/models/user.dart';

class UserController extends GetxController {
  final Rx<UserModel> _userModel = UserModel().obs;
  UserModel get user => _userModel.value;

  RxBool isAllowAlert = true.obs;
  RxInt userTardyAmount = 0.obs;

  set user(UserModel value) => _userModel.value = value;

  void clear() {
    _userModel.value = UserModel();
  }
}
