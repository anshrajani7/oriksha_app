import 'package:oriksha_application/ApiServices/api_services.dart';
import 'package:get/get.dart';
import '../../../core/Utils/common_constor.dart';
import '../../../core/Utils/hive_keys.dart';
import '../../../model/passanger_model.dart';
import '../../../model/ride_history_model.dart';

class TransactionListController extends GetxController {
  RxList<RideItem>? passengerRideHistoryList;
  RxList<RideHistoryItemPass>? driverRideHistoryList;

  @override
  void onInit() {
    super.onInit();
    onInitFun();
  }

  Future<void> onInitFun() async {
    bool isPassenger =
        Constant.instance.dbHelper.driver.get(HiveKeys.isPassenger) ?? false;
    RxList<dynamic>? fetchedData = await APIs.rideHistoryApi();

    if (fetchedData != null) {
      if (isPassenger) {
        passengerRideHistoryList?.clear();
        passengerRideHistoryList = fetchedData.cast<RideItem>().where(
              (item) => item.driverId.isNotEmpty,
        ).toList().obs;
      } else {
        driverRideHistoryList?.clear();
        driverRideHistoryList = fetchedData.cast<RideHistoryItemPass>().where(
              (item) => item.driverId.isNotEmpty,
        ).toList().obs;
      }
    } else {
      // Handle error case
    }
    update();
  }

}
