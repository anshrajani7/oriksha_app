import 'package:oriksha_application/presentation/Driver_Map_Page/controller/driver_map_controller.dart';
import 'package:get/get.dart';




class DriverMapScreenBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => DriverMapScreenController());
  }

}