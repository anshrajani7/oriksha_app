
import 'package:oriksha_application/core/app_export.dart';
import 'package:oriksha_application/presentation/Verify_Otp_Page/controller/verify_otp_controller.dart';

class VerifyOtpScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VerifyOtpScreenController());
  }
}
