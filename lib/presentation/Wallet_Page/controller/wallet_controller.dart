import 'package:oriksha_application/ApiServices/api_services.dart';
import 'package:oriksha_application/core/app_export.dart';

class WalletScreenController extends GetxController{
  TextEditingController naController =TextEditingController();
  List<String> imagePaths = [
    'assets/icons/recharge.svg',
    'assets/icons/withdraw.svg',
    'assets/icons/sendMoney.svg',
    'assets/icons/lockMoney.svg',
  ];
  List<String> text = [
    AppString.recharge.tr,
    AppString.withdraw.tr,
    AppString.sendRupees.tr,
    AppString.lockAmount.tr,
  ];
  @override
  void onInit() {
     APIs.showAmountApi();
    super.onInit();
  }

}