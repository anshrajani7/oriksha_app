import 'package:oriksha_application/presentation/MyBankDetails_QRCode_Page/controller/mybankdetails_QRcode_controller.dart';
import 'package:get/get.dart';

class MyBankDetailsBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => MyBankDetailsController());
  }
}
