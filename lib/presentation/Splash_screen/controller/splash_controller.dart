import 'package:oriksha_application/ApiServices/Common_Modal/Network_info.dart';
import 'package:oriksha_application/core/Utils/common_constor.dart';
import 'package:oriksha_application/core/Utils/hive_keys.dart';
import 'package:oriksha_application/core/app_export.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart'as permission;


import '../../../ApiServices/api_services.dart';

class SplashController extends GetxController{
  final Location location = Location();
  RxBool isUserLogin = false.obs;
  RxBool isAdminLogin = false.obs;

  @override
  void onInit()  {
    onInitFunction();
    super.onInit();
  }

  Future<void>  onInitFunction()async{
    await _checkNetworkStatus();
    await _initLocation();
    isUserLogin.value =
        await Constant.instance.dbHelper.driver.get(HiveKeys.isPassenger) ?? false;
    APIs.onLoadImage();
    if(isUserLogin.isTrue){

    }
    isAdminLogin.value =
        await Constant.instance.dbHelper.driver.get(HiveKeys.isDriver) ?? false;
  }
  Future<void> _initLocation() async {
     permission.PermissionStatus status1 = await permission.Permission.phone.status;
    if (status1.isDenied) {
      // Permission Granted
      status1 = await permission.Permission.phone.request();
      if (status1.isDenied) {
        return;
      }
    }
    permission.PermissionStatus status = await permission.Permission
        .locationWhenInUse.status;
    if (status.isDenied) {
      status = await permission.Permission.locationWhenInUse.request();
      if (status.isDenied) {
        return;
      }
    }
    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
  }

  Future<void> _checkNetworkStatus() async {
    bool isNetworkAvailable =await  NetworkInfo.checkNetwork();
    if (!isNetworkAvailable) {
    } else {
      routeScreen();
    }
  }
  Future<void> routeScreen() async {
    try {
      await Future.delayed(const Duration(seconds: 3)).then((value) async {

       isUserLogin.value
            ?await Get.offAllNamed(AppRoutes.homeScreenRoutes,arguments: 1)
            : isAdminLogin.value
            ?await Get.offAllNamed(AppRoutes.homeScreenRoutes,arguments: 2)
            :await Get.offAllNamed(AppRoutes.onBoardingScreenRoute);
      });
    } catch (e) {
      // Handle any potential errors during the async operation
      if (kDebugMode) {
        print('Error in routeScreen: $e');
      }
    }
  }
}