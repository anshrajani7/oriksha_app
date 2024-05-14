import 'package:oriksha_application/presentation/Legal_page/controller/legal_controller.dart';
import 'package:get/get.dart';

class LegalBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => LegalController());
  }

}