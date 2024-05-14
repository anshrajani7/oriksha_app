
import 'package:oriksha_application/core/app_export.dart';
import 'package:oriksha_application/presentation/Home_Page/controller/home_controller.dart';

class HomeScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeScreenController());
  }
}
