import 'package:oriksha_application/presentation/Driver_DashBord_Page/controller/driver_dashbord_controller.dart';
import 'package:get/get.dart';


class DriverDashBordScreenBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => DriverDashBordScreenController());
  }

}