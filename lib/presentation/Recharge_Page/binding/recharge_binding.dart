import 'package:oriksha_application/presentation/Recharge_Page/controller/recharge_controller.dart';
import 'package:get/get.dart';

class RechargeBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => RechargeController());
  }

}