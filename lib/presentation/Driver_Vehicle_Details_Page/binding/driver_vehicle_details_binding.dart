import 'package:get/get.dart';

import '../controller/driver_vehicle_details_controller.dart';

class DriverVehicleDetailsBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => DriverVehicleDetailsController());
  }

}