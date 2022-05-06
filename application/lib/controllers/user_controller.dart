import 'package:get/get.dart';
import 'package:soup/models/stock.dart';
import 'package:soup/models/user.dart';
import 'package:soup/services/account.dart';
import 'package:soup/services/xingapi.dart';

class UserController extends GetxController with StateMixin {
  final Rx<UserModel> _userModel = UserModel().obs;
  UserModel get user => _userModel.value;

  RxBool isAllowAlert = true.obs;
  Rx<UserInformation?> userInformation = Rx(null);
  Rx<List<OwnedStock>> ownedStockList = Rx([]);

  RxInt userTardyAmount = 0.obs;

  set user(UserModel value) => _userModel.value = value;

  @override
  void onInit() async {
    await refreshData();
    super.onInit();
  }

  void clear() {
    _userModel.value = UserModel();
  }

  Future<void> refreshData() async {
    change(null, status: RxStatus.loading());
    await getDeposit();
    change(null, status: RxStatus.success());
  }

  Future<void> getDeposit() async {
    final response =
        await XingAPI(accountStr: Account.account, password: Account.password)
            .getAccountStockBalance();
    if (response['success'] == true) {
      userInformation.value = UserInformation.fromJson(
          json: response['content']['body']['t0424OutBlock'][0]);
      ownedStockList.value = List<OwnedStock>.from(response['content']['body']
              ['t0424OutBlock1']
          .map((json) => OwnedStock.fromJson(json)));
    }
  }
}
