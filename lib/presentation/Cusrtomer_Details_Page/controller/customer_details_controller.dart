import 'package:oriksha_application/ApiServices/api_services.dart';
import 'package:oriksha_application/widget/custom_snakBar.dart';

import '../../../core/app_export.dart';

class CustomerDetailsController extends GetxController {
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController referralController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  RxBool checkBox=false.obs;
  RxBool isVisible = true.obs;
  RxBool isVisible1 = true.obs;
  RxString pinNumber = ''.obs;
  RxString confirmPinNumber = ''.obs;

  void iSVisibleFun() {
    isVisible.value = !isVisible.value;
  }

  void iSVisibleFun1() {
    isVisible1.value = !isVisible1.value;
  }

  Future<void> isRegister() async{
    if (nameController.text.isEmpty) {
      CustomSnackBar.showSnackBar(
          headerText: AppString.error.tr,
          bodyText: AppString.pleaseEnterName.tr);
    } else if (mobileController.text.isEmpty ||
        mobileController.text.length < 10) {
      CustomSnackBar.showSnackBar(
          headerText: AppString.error.tr,
          bodyText: mobileController.text.isEmpty
              ? AppString.pleaseEnterYourMobileNumberToContinue.tr
              : AppString.pleaseEnterValidMobileNumber.tr);
    } else if(confirmPinNumber.value.isEmpty){
      CustomSnackBar.showSnackBar(
          headerText: AppString.error.tr,
          bodyText: AppString.pleaseEnterConfirmPin.tr);
    }else if(pinNumber.value!=confirmPinNumber.value){
      CustomSnackBar.showSnackBar(
          headerText: AppString.error.tr,
          bodyText: AppString.pinOrConfirmPinNotMatch.tr);
    }else if(checkBox.isFalse){
      CustomSnackBar.showSnackBar(
          headerText: AppString.error.tr,
          bodyText: AppString.pleaseCheckATermsAndCondition.tr);
    }else{
      await APIs.sendOtpApi(mobileNum: mobileController.text);
      Get.toNamed(AppRoutes.verifyOtpScreenRoutes,arguments: 'passenger');
    }
  }
}
