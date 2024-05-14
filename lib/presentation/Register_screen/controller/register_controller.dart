import 'package:oriksha_application/routes/app_routes.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController{
  RxBool switchValue = true.obs;

  void onPressed(){
    if (switchValue.isFalse) {
      Get.toNamed(AppRoutes.drivervehicledetailsScreenRoutes);
    } else {
      Get.toNamed(AppRoutes.customerDetailsScreenRoutes);

    }
  }
}