import 'package:oriksha_application/presentation/Transactions_details_page/controller/transactions_details_controller.dart';
import 'package:get/get.dart';

class TransactionDetailsBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => TransactionDetailsController());
  }

}