import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:oriksha_application/ApiServices/api_services.dart';

import '../../../core/Utils/string_constant.dart';
import '../../../widget/custom_snakBar.dart';

class ForgatePasswordScreenController extends GetxController{
  TextEditingController senderTextController=TextEditingController();
  TextEditingController amountTextController=TextEditingController();
  TextEditingController otpTextController=TextEditingController();
  RxBool otpVerify=false.obs;
  RxBool sendOtp=false.obs;
  RxBool switchValue=false.obs;
otpVerifyFun(){
  if (otpTextController.text.isEmpty) {
    CustomSnackBar.showSnackBar(
        headerText: AppString.error.tr, bodyText: AppString.pleaseEnterOtp.tr);
  } else if (APIs.otpCord.value.toString() != otpTextController.text ) {
    CustomSnackBar.showSnackBar(
        headerText: AppString.error.tr, bodyText: "Please Valid Otp Enter!");
  } else{
    otpVerify.value=true;
  }
  }
}