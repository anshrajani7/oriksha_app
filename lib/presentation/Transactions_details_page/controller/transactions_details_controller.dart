import 'package:get/get.dart';

import '../../../model/passanger_model.dart';
import '../../../model/ride_history_model.dart';

class TransactionDetailsController extends GetxController{
  RideItem? passengerRideHistoryList;
 RideHistoryItemPass? driverRideHistoryList;
 RxString type=''.obs;
@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    var data= Get.arguments;
    type.value=data['type'];
    if("passenger"!=type.value){
      driverRideHistoryList = data['data'];
    }else{
      passengerRideHistoryList=data['data'];
    }
  }

}