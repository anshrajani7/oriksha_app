
import 'package:oriksha_application/core/app_export.dart';
import 'package:oriksha_application/presentation/Serch_Page/controller/serch_controller.dart';

class SerchScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SerchScreenController());
  }
}
