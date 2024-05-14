import 'dart:io';

import 'package:oriksha_application/widget/custom_image_picker.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:image_picker/image_picker.dart';

import '../../../ApiServices/api_services.dart';
import '../../../core/app_export.dart';

class DriverVehicleDetailsController extends GetxController {
  TextEditingController vehicleNumberController = TextEditingController();
  TextEditingController licenceNumberController = TextEditingController();
  RxString driverImage = AppString.chooseFile.tr.obs;
  RxString vehicleFrontImage = AppString.chooseFile.tr.obs;
  RxString vehicleBackImage = AppString.chooseFile.tr.obs;
  bool driverPicture = false;
  bool vehicleFrontPicture = false;
  bool vehicleBackPicture = false;

  Future<void> pickImageGallery({required String name}) async {
    final pickedFile = await CustomGalleryDialog.instance
        .selectImageFromSystem(ImageSource.gallery);

    if (pickedFile != null) {
      name == "driver"
          ? await detectFaces(File(pickedFile.path))
          : name == "vehicleFrontImage"
              ? vehicleFrontImage.value = pickedFile.path
              : vehicleBackImage.value = pickedFile.path;
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
      name == "driver"
          ? await detectFaces(File(pickedFile.path))
          : name == "vehicleFrontImage"
              ? vehicleFrontImage.value = pickedFile.path
              : vehicleBackImage.value = pickedFile.path;
      Get.back();
    } else {
      if (kDebugMode) {
        print('No image selected.');
      }
    }
  }

  Future<void> detectFaces(File imageFile) async {
    final inputImage = InputImage.fromFile(imageFile);
    final faceDetector = FaceDetector(options: FaceDetectorOptions());

    try {
      final faces = await faceDetector.processImage(inputImage);
      if (faces.isNotEmpty) {
        // Face detected
        driverImage.value = imageFile.path;
      } else {
        // No face detected
        Future.delayed(const Duration(microseconds: 100)).then((value) =>
            CustomSnackBar.showSnackBar(
                headerText: AppString.error.tr,
                bodyText: AppString.pleaseSelectAFaceSelfieImage.tr));
      }
    } catch (e) {
      // Error occurred during face detection
      print('Error detecting faces: $e');
    } finally {
      faceDetector.close();
    }
  }

  Future<void> isRegister() async {
    if (vehicleNumberController.text.isEmpty ||
        vehicleNumberController.text.length < 10) {
      CustomSnackBar.showSnackBar(
          headerText: AppString.error.tr,
          bodyText: vehicleNumberController.text.isEmpty
              ? AppString.pleaseEnterVehicleNumber.tr.tr
              : AppString.pleaseEnterValidVehicleNumber.tr);
    } else if (licenceNumberController.text.isEmpty ||
        licenceNumberController.text.length < 16) {
      CustomSnackBar.showSnackBar(
          headerText: AppString.error.tr,
          bodyText: licenceNumberController.text.isEmpty
              ? AppString.pleaseEnterLicenceNumber.tr
              : AppString.pleaseEnterValidLicenceNumber.tr);
    } else if (!driverImage.value.isImageFileName) {
      CustomSnackBar.showSnackBar(
        headerText: AppString.error.tr,
        bodyText: AppString.pleasePickDriverPhoto.tr,
      );
    } else if (!vehicleFrontImage.value.isImageFileName) {
      CustomSnackBar.showSnackBar(
        headerText: AppString.error.tr,
        bodyText: AppString.pleasePickVehiclePhotoFront.tr,
      );
    } else if (!vehicleBackImage.value.isImageFileName) {
      CustomSnackBar.showSnackBar(
        headerText: AppString.error.tr,
        bodyText: AppString.pleasePickVehiclePhotoBack.tr,
      );
    } else {
      await APIs.vehiclePhotoAdd(
          vehicalFrontPhoto: File(vehicleFrontImage.value),
          vehiclePhoBack: File(vehicleBackImage.value),
          driverPhoto: File(driverImage.value),
          vehicleNumber: vehicleNumberController.text);
      Get.toNamed(AppRoutes.driverDetailsScreenRoutes);
    }
  }
}
