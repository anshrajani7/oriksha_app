
import 'package:oriksha_application/core/app_export.dart';
import 'package:oriksha_application/presentation/Profile_Page/controller/profile_controller.dart';

class ProfileScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileScreenController());
  }
}
