import 'package:get/get.dart';

import '../controller/forgate_password_controller.dart';



class ForgatePasswordScreenBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => ForgatePasswordScreenController());
  }
}