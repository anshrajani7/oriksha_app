import 'package:oriksha_application/ApiServices/api_services.dart';
import 'package:oriksha_application/core/Utils/common_constor.dart';
import 'package:oriksha_application/core/Utils/hive_keys.dart';
import 'package:oriksha_application/core/app_export.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RechargeController extends GetxController {
  double padding = 20;
  RxString amount = "".obs;

  // for Keypad
  List<List<int>> keyboardList = [
    [1, 2, 3],
    [4, 5, 6],
    [
      7,
      8,
      9,
    ],
    [-1, 0, -2]
  ];
  late Razorpay _razorpay;

  @override
  void onInit() {
    _razorpay = Razorpay(
    );
    super.onInit();
  }

  @override
  void onClose() {
    _razorpay.clear();
    super.onClose();
  }

  void openCheckout()async {

   var mobile=await Constant.instance.dbHelper.driver.get(HiveKeys.mobileNumber)??await Constant.instance.dbHelper.passenger.get(HiveKeys.mobileNumber);
   var email=await Constant.instance.dbHelper.driver.get(HiveKeys.email)??await Constant.instance.dbHelper.passenger.get(HiveKeys.email)??'abc@gmail.com';
   var id=await Constant.instance.dbHelper.driver.get(HiveKeys.id)??await Constant.instance.dbHelper.passenger.get(HiveKeys.id);
   var options = {
     'key': 'rzp_test_pZextSjoVg0oKW',
     'amount': double.parse(amount.value) * 100,
     'name': 'Petroling oriksha_application Pvt Ltd',
     'description': 'Add a Wallet Balance',
     'retry': {'enabled': true, 'max_count': 1},
     'send_sms_hash': true,
     'prefill': {
       'contact': '$mobile',
       'email': '$email'
     },
     'external': {
       'wallets': ['gpay', 'phonpay'],
       'upi': ['upi']
     }
   };



   try {
     _razorpay.open(options);
   } catch (e) {
     print('Error initiating Razorpay payment: $e');
   }

   _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, (PaymentSuccessResponse response) async {
     print('Payment successful: ${response.paymentId}');
    await APIs.addPaymentApi( transectionId: response.paymentId.toString(), amount: amount.value);
     Get.offNamed(AppRoutes.transactionSuccessfullyScreenRoutes);
     // Handle success event
   });

   _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, (PaymentFailureResponse response) {
     print('Payment error: ${response.code}, ${response.message}');
     // Handle error event
   });

   _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, (ExternalWalletResponse response) {
     print('External wallet selected: ${response.walletName}');
     // Handle external wallet event
   });

 }
}
