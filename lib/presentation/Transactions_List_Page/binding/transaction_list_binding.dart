import 'package:oriksha_application/presentation/Transactions_List_Page/controller/transaction_list_controller.dart';
import 'package:get/get.dart';

class TransactionListBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => TransactionListController());
  }

}