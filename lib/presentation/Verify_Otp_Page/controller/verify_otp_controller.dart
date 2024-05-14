import 'package:oriksha_application/ApiServices/api_services.dart';
import 'package:oriksha_application/core/app_export.dart';
import 'package:oriksha_application/presentation/Cusrtomer_Details_Page/controller/customer_details_controller.dart';
import 'package:oriksha_application/presentation/Driver_Vehicle_Details_Page/controller/driver_vehicle_details_controller.dart';
import 'package:oriksha_application/widget/custom_snakBar.dart';
import 'package:get/get.dart';
import 'dart:io';
import '../../Driver_Details_Page/controller/driver_details_controller.dart';

class VerifyOtpScreenController extends GetxController {
  RxString otpNumber = ''.obs;
  var data;
  RxString mobileNumber = ''.obs;

  @override
  onInit() {
    super.onInit();
    data = Get.arguments;
    if (data == "driver") {
      DriverDetailsController driverDetailsController =
      Get.find<DriverDetailsController>();
      mobileNumber.value = driverDetailsController.mobileNumController.text;
    } else {
      CustomerDetailsController customerDetailsController =
      Get.find<CustomerDetailsController>();
      mobileNumber.value = customerDetailsController.mobileController.text;
    }
  }

  Future<void> verifyOtp() async {
    if (otpNumber.value.isEmpty) {
      CustomSnackBar.showSnackBar(
          headerText: AppString.error.tr, bodyText: AppString.pleaseEnterOtp.tr);
    } else if (APIs.otpCord.value.toString() != otpNumber.value ) {
      CustomSnackBar.showSnackBar(
          headerText: AppString.error.tr, bodyText: "Please Valid Otp Enter!");
    } else if (data == "driver") {
      DriverDetailsController driverDetailsController =
      Get.find<DriverDetailsController>();
      DriverVehicleDetailsController driverVehicleDetailsController =
      Get.find<DriverVehicleDetailsController>();
      await APIs.driverRegisterApi(
          email: driverDetailsController.emailController.text,
          password: driverDetailsController.pinNumber.value,
          aadharNum: driverDetailsController.aadharNumController.text,
          refferlcode: driverDetailsController.referralController.text,
          driverName: driverDetailsController.nameController.text,
          mobileNum: driverDetailsController.mobileNumController.text,
          vehicleNumber:
          driverVehicleDetailsController.vehicleNumberController.text,
          licenceNumber:
          driverVehicleDetailsController.licenceNumberController.text);
      showWelcomeBonusDialog();

      // No need to delay here
      handelRoute(APIs.isLoading.value);

    } else {
      CustomerDetailsController customerDetailsController =
      Get.find<CustomerDetailsController>();
      await APIs.passengerRegisterApi(
          email: customerDetailsController.emailController.text,
          password: customerDetailsController.pinNumber.value,
          refferlcode: customerDetailsController.referralController.text,
          name: customerDetailsController.nameController.text,
          mobileNum: customerDetailsController.mobileController.text);
      Future.delayed(Duration(milliseconds: 5)).then((value) =>
          handelRoute(APIs.isLoading.value)
      );
    }
  }

  void handelRoute(bool isLoading) {
    if (isLoading) {
      Get.offAllNamed(AppRoutes.homeScreenRoutes);
    }
  }
  void showWelcomeBonusDialog() {
    Get.dialog(
      AlertDialog(
        backgroundColor: ColorConstant.primaryOrg,
        title: Text("Welcome Bonus"),
        content: Text("Congratulations! You have successfully completed driver verification. You received a welcome bonus of Rs. 20."),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }
}
