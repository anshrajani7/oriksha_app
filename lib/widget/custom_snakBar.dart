import 'package:oriksha_application/core/app_export.dart';
class CustomSnackBar {
  static showSnackBar({headerText, bodyText}) {
    Get.closeAllSnackbars();
    Get.snackbar(headerText, bodyText,
        snackPosition: SnackPosition.TOP,
        colorText: ColorConstant.primaryBlack,
        backgroundColor: Colors.orange.shade50,
        margin: const EdgeInsets.only(bottom: 26, left: 16, right: 16));
  }
}
