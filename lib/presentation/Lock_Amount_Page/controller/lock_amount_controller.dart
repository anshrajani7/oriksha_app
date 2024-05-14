import 'package:get/get.dart';
import 'package:oriksha_application/ApiServices/api_services.dart';

class LockAmountScreenController extends GetxController{
@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    APIs.lockAmountApi();
  }
}