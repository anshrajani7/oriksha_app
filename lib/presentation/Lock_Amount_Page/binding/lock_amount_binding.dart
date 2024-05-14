import 'package:get/get.dart';
import 'package:oriksha_application/presentation/Lock_Amount_Page/controller/lock_amount_controller.dart';

class LockAmountScreenBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => LockAmountScreenController());
  }
}