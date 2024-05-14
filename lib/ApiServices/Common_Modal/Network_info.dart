
// // For checking internet connectivity


import 'package:oriksha_application/core/app_export.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';

abstract class NetworkInfo {
  static Future<bool> checkNetwork() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      Get.closeAllSnackbars();
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      Get.closeAllSnackbars();
      return true;
    } else {
      if (connectivityResult == ConnectivityResult.none) {
        Get.snackbar("ERROR MESSAGE".tr, "NO INTERNET CONNECTION".tr,
            snackPosition: SnackPosition.TOP,
            colorText: ColorConstant.primaryBlack,
            backgroundColor: Colors.orange.shade50,
            margin: const EdgeInsets.only(bottom: 26, left: 16, right: 16));
        checkNetwork();
        return false;
      } else {
        return true;
      }
    }
  }
}
