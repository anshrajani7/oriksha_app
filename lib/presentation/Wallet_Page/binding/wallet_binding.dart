
import 'package:oriksha_application/core/app_export.dart';
import 'package:oriksha_application/presentation/Wallet_Page/controller/wallet_controller.dart';

class WalletScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WalletScreenController());
  }
}
