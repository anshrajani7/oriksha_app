import 'package:get/get.dart';

import '../controller/send_amount_controller.dart';




class SendAmountScreenBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => SendAmountScreenController());
  }
}