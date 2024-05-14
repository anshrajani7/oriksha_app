import 'package:get/get.dart';
import '../controller/customer_details_controller.dart';

class CustomerDetailsBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => CustomerDetailsController());
  }

}