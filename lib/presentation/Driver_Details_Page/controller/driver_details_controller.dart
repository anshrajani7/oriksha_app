import 'package:oriksha_application/widget/custom_image_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../../ApiServices/api_services.dart';
import '../../../core/app_export.dart';

class DriverDetailsController extends GetxController {
  RxString aadharFrontImage = AppString.chooseFile.tr.obs;
  RxString aadharBackImage = AppString.chooseFile.tr.obs;
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileNumController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController aadharNumController = TextEditingController();
  TextEditingController referralController = TextEditingController();
  RxBool aadharPhoto = false.obs;
  RxBool aadharPhotoBack = false.obs;
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


  Future<void> pickImageGallery({required String name}) async {
    final pickedFile = await CustomGalleryDialog.instance
        .selectImageFromSystem(ImageSource.gallery);
    if (pickedFile != null) {
      name == "front"
          ? aadharFrontImage.value = pickedFile.path
          : aadharBackImage.value = pickedFile.path;
      name == 'front' ? aadharPhoto.value = true : aadharPhotoBack.value = true;
      Get.back();
    } else {
      if (kDebugMode) {
        print('No image selected.');
      }
    }
  }

  Future<void> pickImageCamera({required String name}) async {
    //
    final pickedFile = await CustomGalleryDialog.instance
        .selectImageFromSystem(ImageSource.camera);

    if (pickedFile != null) {
      name == 'front'
          ? aadharFrontImage.value = pickedFile.path
          : aadharBackImage.value = pickedFile.path;
      name == 'front' ? aadharPhoto.value = true : aadharPhotoBack.value = true;
      Get.back();

    } else {
      if (kDebugMode) {
        print('No image selected.');
      }
    }
  }

  Future<void> isRegister() async {
    if (nameController.text.isEmpty) {
      CustomSnackBar.showSnackBar(
          headerText: AppString.error.tr,
          bodyText: AppString.pleaseEnterName.tr);
    } else if (mobileNumController.text.isEmpty ||
        mobileNumController.text.length < 10) {
      CustomSnackBar.showSnackBar(
          headerText: AppString.error.tr,
          bodyText: mobileNumController.text.isEmpty
              ? AppString.pleaseEnterYourMobileNumberToContinue.tr
              : AppString.pleaseEnterValidMobileNumber.tr);
    } else
    if (!emailController.text.isEmail) {
      CustomSnackBar.showSnackBar(
          headerText: AppString.error.tr,
          bodyText: AppString.pleaseEnterEmailId.tr);
    } else if (pinNumber.isEmpty) {
      CustomSnackBar.showSnackBar(
          headerText: AppString.error.tr,
          bodyText: AppString.pleaseEnterPin.tr);
    } else if (confirmPinNumber.isEmpty) {
      CustomSnackBar.showSnackBar(
          headerText: AppString.error.tr,
          bodyText: AppString.pleaseEnterConfirmPin.tr);
    } else if (pinNumber.value != confirmPinNumber.value) {
      CustomSnackBar.showSnackBar(
          headerText: AppString.error.tr,
          bodyText: AppString.pinOrConfirmPinNotMatch.tr);
    } else if (aadharNumController.text.isEmpty ||
        aadharNumController.text.length < 14) {
      CustomSnackBar.showSnackBar(
          headerText: AppString.error.tr,
          bodyText: aadharNumController.text.isEmpty
              ? AppString.pleaseEnterAdharNumber.tr
              : AppString.pleaseEnterValidAdharNumber.tr);
    } else if (!aadharFrontImage.value.isImageFileName) {
      CustomSnackBar.showSnackBar(
          headerText: AppString.error.tr,
          bodyText: AppString.pleaseSelectAAadhaarImageFront.tr);
    } else if (pinNumber.value != confirmPinNumber.value) {
      CustomSnackBar.showSnackBar(
          headerText: AppString.error.tr,
          bodyText: "PIN OR CONFIRM PIN NOT MATCH");
    }  else {
     await APIs.aadharPhotoAdd(
          aadharPhotFront: File(aadharFrontImage.value),
          aadharPhotBack: File(aadharBackImage.value),
          vehicleNumber: aadharNumController.text);
      await APIs.sendOtpApi(mobileNum: mobileNumController.text);
      Get.toNamed(AppRoutes.verifyOtpScreenRoutes,arguments: 'driver');
    }
  }
}
