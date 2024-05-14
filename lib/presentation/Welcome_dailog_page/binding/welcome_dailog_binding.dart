import 'package:oriksha_application/presentation/Welcome_dailog_page/controller/welcome_dailog_controller.dart';
import 'package:get/get.dart';

class WelcomeDailogBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => WelcomeDailogController());
  }
}
