import 'dart:io';
import 'package:oriksha_application/ApiServices/api_services.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/Utils/common_constor.dart';
import '../../../core/Utils/hive_keys.dart';
import '../../../core/app_export.dart';
import '../../../model/user_profile_model.dart';
import '../../../widget/custom_image_picker.dart';

class ProfileScreenController extends GetxController {
  late TextEditingController nameController =
      TextEditingController();
  late TextEditingController addressController = TextEditingController();
  late TextEditingController pinCodeController = TextEditingController();
  RxString name = ''.obs;
  RxString address = ''.obs;
  RxString pincord = ''.obs;
  UserProfileModel userProfileModel = UserProfileModel();
  RxString? imageUrl = "".obs;
  var imageFileParth;
  @override
  void onInit() {
    super.onInit();
    onInitFunction();
  }

  onInitFunction()async {
    imageUrl?.value =await Constant.instance.dbHelper.driver
            .get(HiveKeys.image) ??await Constant.instance.dbHelper.passenger.get(HiveKeys.image)??
        "https://pbs.twimg.com/profile_images/1321030814436655106/87OcbZNm_400x400.jpg";
    nameController.text=await Constant.instance.dbHelper.passenger.get(HiveKeys.name) ??
        Constant.instance.dbHelper.driver.get(HiveKeys.name) ??
        "Your Name";
    addressController.text =await Constant.instance.dbHelper.passenger.get(HiveKeys.address) ??
        Constant.instance.dbHelper.driver.get(HiveKeys.address) ??
        "";
    pinCodeController.text =await Constant.instance.dbHelper.passenger.get(HiveKeys.pincord) ??
        Constant.instance.dbHelper.driver.get(HiveKeys.pincord) ??
        "";
  }

  RxString selectedImagePath = ''.obs;

  Future<void> pickImageGallery() async {
    final pickedFile = await CustomGalleryDialog.instance
        .selectImageFromSystem(ImageSource.gallery);

    if (pickedFile != null) {
      // Perform face detection
      await detectFaces(File(pickedFile.path));
      Get.back();
    } else {
      if (kDebugMode) {
        print('No image selected.');
      }
    }
  }

  Future<void> pickImageCamera() async {
    final pickedFile = await CustomGalleryDialog.instance
        .selectImageFromSystem(ImageSource.camera);

    if (pickedFile != null) {
      // Perform face detection
      await detectFaces(File(pickedFile.path));

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
        selectedImagePath.value = imageFile.path;
        imageFileParth = imageFile;
      } else {
        // No face detected
        Get.back();

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
  Future<void> updateProfile() async {
    if (imageFileParth != null) {
      await APIs.updateProfileApi(
        name: nameController.text,
        address: addressController.text,
        pincord: pinCodeController.text,
        image: File(imageFileParth.path),
      );
    } else {
      // Handle the case where imageFileParth is null
      // For example, show an error message or take appropriate action
      print('No image selected.');
    }
  }
}
