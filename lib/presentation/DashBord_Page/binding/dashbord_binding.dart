
import 'package:oriksha_application/core/app_export.dart';
import 'package:oriksha_application/presentation/DashBord_Page/controller/dashbord_controller.dart';

class DashBordScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DashBordScreenController());
  }
}
