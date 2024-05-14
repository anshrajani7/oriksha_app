import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:oriksha_application/ApiServices/api_services.dart';

class SendAmountScreenController extends GetxController{
  TextEditingController senderTextController=TextEditingController();
  TextEditingController amountTextController=TextEditingController();
@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    APIs.lockAmountApi();
  }
}