import 'package:oriksha_application/presentation/Onboarding_screen/controller/onboarding_controller.dart';
import 'package:get/get.dart';

class OnBoardingBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => OnBoardingController());
  }

}