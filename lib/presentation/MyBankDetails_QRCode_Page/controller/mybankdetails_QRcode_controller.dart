import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:oriksha_application/ApiServices/api_services.dart';

import '../../../core/app_export.dart';
import '../../../widget/custom_image_picker.dart';

class MyBankDetailsController extends GetxController {
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController iFSCController = TextEditingController();
  TextEditingController holderNameController = TextEditingController();
  RxString qRCordImage = AppString.chooseFile.tr.obs;
var pickedFiles;
  Future<void> pickImageGallery() async {
    final pickedFile = await CustomGalleryDialog.instance
        .selectImageFromSystem(ImageSource.gallery);

    if (pickedFile != null) {
      qRCordImage.value = pickedFile.path;
      pickedFiles=pickedFile;
      Get.back();
    } else {
      if (kDebugMode) {
        print('No image selected.');
      }
    }
  }

  Future<void> pickImageCamera() async {
    //
    final pickedFile = await CustomGalleryDialog.instance
        .selectImageFromSystem(ImageSource.camera);

    if (pickedFile != null) {
      qRCordImage.value = pickedFile.path;
      pickedFiles=pickedFile;
      Get.back();
    } else {
      if (kDebugMode) {
        print('No image selected.');
      }
    }
  }

  Future<void> addBankDetails()async {
    if (accountNumberController.text.length < 9) {
      CustomSnackBar.showSnackBar(
          headerText: "Error", bodyText: "Please Enter a Valid Account Number");
    } else if (iFSCController.text.length < 5) {
      CustomSnackBar.showSnackBar(
          headerText: "Error", bodyText: "Please Enter a Valid IFSC Code");
    } else if (holderNameController.text.isEmpty) {
      CustomSnackBar.showSnackBar(
          headerText: "Error", bodyText: "Please Enter a Name");
    }else if(qRCordImage.isEmpty){
      CustomSnackBar.showSnackBar(headerText: "Error",bodyText: "Please select a image");
    }else{
    await  APIs.addBankDetails(bankAccNum: accountNumberController.text, ifscCode: iFSCController.text, bankHolderName: holderNameController.text, image: File(pickedFiles.path));
    }
  }
}
