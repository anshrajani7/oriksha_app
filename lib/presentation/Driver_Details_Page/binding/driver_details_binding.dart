import 'package:get/get.dart';

import '../controller/driver_details_controller.dart';


class DriverDetailsBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => DriverDetailsController());
  }

}