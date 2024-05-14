
import 'package:oriksha_application/core/app_export.dart';
import 'package:oriksha_application/presentation/Setting_Page/controller/setting_controller.dart';

class SettingScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SettingScreenController());
  }
}
