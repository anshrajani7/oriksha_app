import 'package:oriksha_application/core/Utils/common_constor.dart';
import 'package:oriksha_application/core/Utils/hive_keys.dart';
import 'package:oriksha_application/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardingController extends GetxController{
  RxBool radioValue = false.obs;
  RxBool switchValue = true.obs;
  RxInt index=1.obs;
  void toggleSwitch() {
    switchValue.value = !switchValue.value;
  }
  void switchButton(){
    if (index.value == 0) {
     Get.toNamed(AppRoutes.drivervehicledetailsScreenRoutes);
    } else {
      Get.toNamed(AppRoutes.customerDetailsScreenRoutes);

    }
  }
  RxString selectedLanguage = 'en_GB'.obs;
  @override
  void onInit() {
   selectedLanguage.value=Constant.instance.dbHelper.driver.get(HiveKeys.language)??"en_GB";
    super.onInit();
  }
  
  set changeLanguage(String lang)  {
    Locale locale = Locale(lang);
    Get.updateLocale(locale);
    selectedLanguage.value = lang;
     Constant.instance.dbHelper.driver.put(HiveKeys.language, selectedLanguage.value);
    update(); // Ensure the UI is updated after changing the language
  }
}