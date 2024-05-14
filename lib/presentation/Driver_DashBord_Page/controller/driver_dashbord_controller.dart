import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../ApiServices/api_services.dart';
import '../../../core/Utils/common_constor.dart';
import '../../../core/Utils/hive_keys.dart';
import '../../../core/app_export.dart';

class DriverDashBordScreenController extends GetxController {
  final Location location = Location();
  final StreamController<LatLng> locationStream = StreamController<LatLng>.broadcast();
  final Rx<LatLng?> userLocation = Rx<LatLng?>(null);
  final RxString id = ''.obs;
  RxBool switchValue = true.obs;
   StreamSubscription<LocationData>? locationSubscription; // Add this line
  RefreshController refreshController = RefreshController(initialRefresh: false);
  ScrollController scrollController = ScrollController();
  @override
  void onInit() {
    super.onInit();
    fetchUserData();
    _initLocation();
  }
  void toggleSwitch()async {
    switchValue.value = !switchValue.value;
await APIs.toggeleApi();
  }
  Future<void> fetchUserData() async {
    id.value = Constant.instance.dbHelper.driver.get(HiveKeys.id).toString();
    Future.delayed(
      const Duration(milliseconds: 2),
          () async {
        await APIs.getRideRequestApi(id: id.value);
        refreshController.refreshFailed();
      },
    );
  }
  Future<void> _initLocation() async {

    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }

    }

    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    location.onLocationChanged.listen((LocationData currentLocation) {
      if (switchValue.value) {
        // Only add data to the stream if switch value is true
        if (!locationStream.isClosed) {
          locationStream.add(LatLng(currentLocation.latitude!, currentLocation.longitude!));
          userLocation.value = LatLng(currentLocation.latitude!, currentLocation.longitude!);
          // Call the API function with the updated location
          APIs.driverLocationUpdateApi(
            latitude: currentLocation.latitude!,
            longitude: currentLocation.longitude!,
            id: id.value,
          );
        }
      } else {
        // If switch value is false, cancel the stream subscription
        locationSubscription?.cancel();
      }
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    locationStream.close();
    refreshController.dispose();
    locationSubscription?.cancel();
    super.dispose();
  }

  @override
  void onClose() {
    locationStream.close();
    locationSubscription?.cancel();// Close the stream when the controller is disposed
    super.onClose();
  }

}
