import 'dart:async';

import 'package:location/location.dart';
import 'package:oriksha_application/core/Utils/hive_keys.dart';
import 'package:oriksha_application/presentation/DashBord_Page/controller/dashbord_controller.dart';

import '../../../core/Utils/common_constor.dart';

import 'package:oriksha_application/core/app_export.dart';

class SettingScreenController extends GetxController {
  RxString selectedValue = 'Feedback'.obs;
  RxList<String> options = [
    'The Feedback I Gave',
    'The Feedback I Received',
  ].obs;
  RxBool isDropdownOpen = false.obs;
  // Your existing code



  void logOut() async {
    var isPassanger= await Constant.instance.dbHelper.driver.get(HiveKeys.isPassenger)??false;
    if(isPassanger) {
      DashBordScreenController dashBordScreenController = Get.find<
          DashBordScreenController>();
      dashBordScreenController.stopLocationUpdates();
    }
    await Constant.instance.dbHelper.driver.clear();
    await Constant.instance.dbHelper.passenger.clear();

    // Stop location listener if it's running

    Get.offAllNamed(AppRoutes.loginScreenRoutes);
    Get.showSnackbar(
      GetBar(
        message: 'You have been logged out.',
        duration: Duration(seconds: 3),
      ),
    );
  }
}
