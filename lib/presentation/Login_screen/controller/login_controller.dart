import 'package:oriksha_application/ApiServices/api_services.dart';
import 'package:oriksha_application/core/Utils/common_constor.dart';
import 'package:oriksha_application/core/Utils/hive_keys.dart';
import '../../../core/app_export.dart';
class LogInController extends GetxController {
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController pinController = TextEditingController();

  RxBool isVisible = false.obs;
  RxBool onTap = false.obs;
@override
  void dispose() {
  mobileController.dispose();
  pinController.dispose();
    super.dispose();
  }
  void iSVisibleFun() {
    isVisible.value = !isVisible.value;
  }
  Future<void> onLogin()async {
    if (mobileController.text.length<10) {
      CustomSnackBar.showSnackBar(
          headerText: AppString.error.tr, bodyText: AppString.pleaseMobileNumber.tr);
    } else if (pinController.text.length < 4) {
    CustomSnackBar.showSnackBar(
        headerText: AppString.error.tr, bodyText:AppString.pleaseEnterPin);
    } else {
   await APIs.loginApi(password: pinController.text, mobileNum: mobileController.text);
   handelRoute(APIs.isLoading.value);
    }
  }
  Future<void> handelRoute(bool login) async {
  if(login){
   int ststus= await Constant.instance.dbHelper.driver.get(HiveKeys.status);
   print("=================>$ststus");
   Get.offAllNamed(AppRoutes.homeScreenRoutes,arguments: ststus);
  }
  }

  }
