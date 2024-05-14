import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:oriksha_application/ApiServices/api_services.dart';
import 'package:oriksha_application/core/Utils/common_constor.dart';
import 'package:oriksha_application/core/Utils/hive_keys.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/app_export.dart';
import 'package:geocoding/geocoding.dart' as geo;

class DashBordScreenController extends GetxController {
  final CountDownController countDownController = CountDownController();
  final Rx<GoogleMapController?> mapController = Rx<GoogleMapController?>(null);
  final Location location = Location();
  StreamSubscription<LocationData>? locationSubscription;
  final StreamController<LatLng> locationStream =
      StreamController<LatLng>.broadcast();
  final RxList places = [].obs;
  final Set<Polyline> polylines = <Polyline>{};
  final Rx<LatLng?> userLocation = Rx<LatLng?>(null);
  final RxBool onTap = false.obs;
  final Rx<Set<Marker>> pickupMarker = Rx<Set<Marker>>(<Marker>{});
  final Rx<Set<Marker>> markers = Rx<Set<Marker>>({});
  late   Set<Marker> driverMarkers= <Marker>{};
  RxDouble distance=0.0.obs;
  RxString selectedValue = 'Feedback'.obs;
  RxList<String> options = [
    'The Feedback I Gave',
    'The Feedback i received',
  ].obs;
  RxBool isDropdownOpen = false.obs;
  List sos = [
    "POLICE-100",
    "FIRE-100",
    "AMBULANCE-108, 102",
    "WOMEN HELPLINE-1091/181",
    "BLOOD BANK-1910",
  ];

// Inside your code, where you want to update markers:
  RxBool openBootmSheet = false.obs;
  RxString pickupLocation = ''.obs;
  double pikLat = 0.0;
  double pikLong = 0.0;
  double dropLat = 0.0;
  double dropLong = 0.0;
  RxString dropLocation = ''.obs;
  RxString dropLocation_sub = ''.obs;
  RxString dropLocation_main = ''.obs;
  RxString pickup_main = ''.obs;
  RxString pickup_text = ''.obs;
  RxString totalDuration = ''.obs;
  RxString totalPrice = ''.obs;
  RxString totalDistance = ''.obs;
  RxString mobile = ''.obs;
  RxInt id = 0.obs;
 RxBool hasData=true.obs;
 RxBool oneTime=false.obs;

  RxInt minutes = 1.obs;
  RxInt seconds = 0.obs;
  RxBool isRunning = false.obs;

  void startTimer() {
    isRunning.value = true;
    Duration duration = Duration(minutes: minutes.value, seconds: seconds.value);
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (duration.inSeconds == 0) {
        timer.cancel();
        stopTimer();
        isRunning.value = false;
      } else {
        duration -= const Duration(seconds: 1);
        minutes.value = duration.inMinutes;
        seconds.value = duration.inSeconds % 60;
      }
    });
  }
void cancelRide(){
  isRunning.value = false;
  polylines.clear();
  openBootmSheet.value = false;
  polylines.clear();
  pickupMarker.value.clear();
  update();
  oneTime.value=false;
  APIs.bottomSheet.value=false;
  CustomSnackBar.showSnackBar(headerText: AppString.success.tr,bodyText: "Ride Request Cancel Successfully");
  APIs.rideArrive.value=false;
}
  void stopTimer() {
    isRunning.value = false;
    polylines.clear();
    openBootmSheet.value = false;
    polylines.clear();
    pickupMarker.value.clear();
    oneTime.value=false;
    APIs.bottomSheet.value=false;
    update();
    CustomSnackBar.showSnackBar(headerText: AppString.error.tr,bodyText: "Driver is Not Response Please try again");

    APIs.rideArrive.value=false;
  }
  void rideisComplate(){
    isRunning.value = false;
    polylines.clear();
    markers.value.clear();
    openBootmSheet.value = false;
    polylines.clear();
    pickupMarker.value.clear();
    pickupLocation.value='';
    update();
    CustomSnackBar.showSnackBar(headerText: AppString.success.tr,bodyText: "Your Ride is Complete");

    APIs.rideArrive.value=false;
  }

  @override
  void onInit() {
    APIs.rideArrive.value=false;
    _initLocation();
    mobile.value =
        Constant.instance.dbHelper.passenger.get(HiveKeys.mobileNumber) ?? "";
    id.value = Constant.instance.dbHelper.passenger.get(HiveKeys.id) ?? 0;
    super.onInit();
  }

  void updateMarkerPosition(LatLng newPosition) {
    // Clear the previous marker and add a new one at the center
    markers.value.add(
      Marker(
        markerId: const MarkerId('CurrentLocation'),
        position: newPosition,
        infoWindow: const InfoWindow(title: "Current Location"),
        icon: BitmapDescriptor.fromBytes(APIs.markerIcons[3]),
      ),
    );

    // Update the map
    update();
  }

  Future<void> _initLocation() async {
    hasData.value=true;
    location.onLocationChanged.listen((LocationData currentLocation) async {
      locationStream
          .add(LatLng(currentLocation.latitude!, currentLocation.longitude!));
      userLocation.value =
          LatLng(currentLocation.latitude!, currentLocation.longitude!);
     if(oneTime.isFalse){
       final coordinates = LatLng(
           userLocation.value!.latitude, userLocation.value!.longitude);
       List<geo.Placemark> placemarks =
       await geo.placemarkFromCoordinates(
           coordinates.latitude,
           coordinates.longitude);
       if (placemarks.isNotEmpty) {
         pickup_main.value = placemarks
             .first.thoroughfare
             .toString()
             .isEmpty
             ? placemarks.first.subLocality.toString()
             : placemarks.first.thoroughfare.toString();
         pickup_text.value = placemarks
             .first.thoroughfare
             .toString()
             .isEmpty
             ? placemarks.first.locality.toString()
             : placemarks.first.subLocality.toString();
         pickupLocation.value =
         "${placemarks.first.thoroughfare} ${placemarks.first.subLocality} ${placemarks.first.locality}";
         pikLat = userLocation.value!.latitude;
         pikLong = userLocation.value!.longitude;
         markers.value = {
           Marker(
             markerId: const MarkerId('pickup_marker'),
             position: userLocation.value!,
             infoWindow:
             const InfoWindow(title: "Pickup Point"),
             icon: BitmapDescriptor.fromBytes(
                 APIs.markerIcons[1]),
           )
         };
       }
       oneTime.value=true;
     }
      if(APIs.rideArrive.isFalse) {
        await fetchDriverData();
      }else{
        pickupMarker.value.clear();
        updateMarkerPosition(userLocation.value!);
      }
    });
    hasData.value=false;
  }

  Future<void> fetchDriverData() async {
    try {
      // Fetch driver data using the detallUserDataApi method
      await APIs.getAllDriverApi(
        latitude: userLocation.value!.latitude,
        longitude: userLocation.value!.longitude,
      );
       driverMarkers = APIs.markers;
      pickupMarker.value.addAll(driverMarkers);
      // Update the UI to display the markers on the map
      update();
    } catch (e) {
      // Handle errors
      if (kDebugMode) {
        print("Error fetching driver data: $e");
      }
    }
  }
  void stopLocationUpdates() {
    if (locationSubscription != null) {
      locationSubscription!.cancel();
    }
  }
  Future<void> bookRide() async {
    await APIs.bookRideApi(
        pickup_lat: pikLat,
        pickup_long: pikLong,
        drop_lat: dropLat,
        drop_long: dropLong,
        pickup_location_main_text: pickup_main.value,
        distance: totalDistance.value,
        price: totalPrice.value,
        drop_location_sub_text: dropLocation_sub.value,
        pickup_location_sub_text: pickup_text.value,
        drop_location_main_text: dropLocation_main.value,
        mobile: mobile.value,
        id: id.value);
    startTimer();
  }


  void showMessage() {
    Fluttertoast.showToast(
      msg: "Please tap and hold for emergency!",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

  @override
  void onClose() {
    if (!locationStream.isClosed) {
      locationStream.close();
      locationStream.onCancel;
    }
    super.onClose();
  }

  @override
  void dispose() {
    if (!locationStream.isClosed) {
      locationStream.close();
    }
    locationSubscription?.cancel();
    super.dispose();
  }

  void policeEmergencyNumber() {
    launch('tel:100');
  }

  void fireEmergencyNumber() {
    launch('tel:101');
  }

  void ambulanceEmergencyNumber() {
    launch('tel:108');
  }

  void womenHelplineEmergencyNumber() {
    launch('tel:181');
  }

  void bloodBankEmergencyNumber() {
    launch('tel:1910');
  }



  void timeOut() {
    openBootmSheet.value = false;
    polylines.clear();
    pickupMarker.value.clear();
    pickupLocation.value='';
    update();
    CustomSnackBar.showSnackBar(headerText: AppString.error.tr,bodyText: "Driver is Late Please try again");
  }
  Future<void> calculateDistance(
      {required LatLng currentLocation, required LatLng pickupLocation}) async {
    // Get the current position
    Position currentPosition = await Geolocator.getCurrentPosition();

    // Calculate the distance between the current location and the pickup location
    double distanceInMeters =  Geolocator.distanceBetween(
      currentPosition.latitude,
      currentPosition.longitude,
      pickupLocation.latitude,
      pickupLocation.longitude,
    );

    // Assign the calculated distance to the RxDouble variable
    distance.value = distanceInMeters;
    print("================>${distance.value}");
  }

}
