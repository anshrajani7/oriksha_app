import 'package:oriksha_application/presentation/Login_screen/controller/login_controller.dart';
import 'package:get/get.dart';

class LogInBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => LogInController());
  }

}