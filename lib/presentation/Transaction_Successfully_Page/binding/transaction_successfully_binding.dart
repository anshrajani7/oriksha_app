import 'package:oriksha_application/presentation/Transaction_Successfully_Page/controller/transaction_successfully_controller.dart';
import 'package:get/get.dart';

class TransactionSuccessfullyBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
 Get.lazyPut(() => TransactionSuccessfullyController());
  }

}