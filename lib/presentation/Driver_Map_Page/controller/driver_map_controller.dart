import 'dart:async';
import 'package:oriksha_application/model/ride_request_driver_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';
import '../../../ApiServices/api_services.dart';
import '../../../core/app_export.dart';
import '../../../model/Location_Model/destination_model.dart';

class DriverMapScreenController extends GetxController {
  late RideRequestDriver data;
  final Location location = Location();
  final StreamController<LatLng> locationStream =
      StreamController<LatLng>.broadcast();
  final RxList places = [].obs;
  final Rx<LatLng?> userLocation = Rx<LatLng?>(null);
  final Set<Polyline> polylines = <Polyline>{};
  final Rx<GoogleMapController?> mapController = Rx<GoogleMapController?>(null);
  final Rx<Set<Marker>> markers = Rx<Set<Marker>>({});
  final Rx<Set<Marker>> pickupMarker = Rx<Set<Marker>>({});
  TextEditingController otpController=TextEditingController();
  RxList <String> list = ['Terrible', 'Bad', 'Okay', 'Good', 'Great'].obs;
  RxString selectText = "".obs;
  RxBool isSet = false.obs;
  RxBool entry = true.obs;
 RxDouble distance = 0.0.obs;
  @override
  onInit() {
    super.onInit();
    data = Get.arguments;
    APIs.rideArrive.value=false;
    _initLocation();
  }

  Future<void> _initLocation() async {
    location.onLocationChanged.listen((LocationData currentLocation) async {
      locationStream
          .add(LatLng(currentLocation.latitude!, currentLocation.longitude!));
      userLocation.value =
          LatLng(currentLocation.latitude!, currentLocation.longitude!);
      mapController.value
          ?.animateCamera(CameraUpdate.newLatLng(userLocation.value!));
      markers.value.clear();
      markers.value.add(
        Marker(
          markerId: const MarkerId('currentLocation'),
          position: userLocation.value!,
          infoWindow: const InfoWindow(title: "current location"),
          icon: BitmapDescriptor.fromBytes(APIs.markerIcons[3]),
        ),
      );
      update();
    });

  }
  Future<void> verifyOtp(String rideId) async {
    if (otpController.text.isEmpty) {
      CustomSnackBar.showSnackBar(
          headerText: AppString.error.tr, bodyText: AppString.pleaseEnterOtp.tr);
    } else if (APIs.otpCord.value.toString() != otpController.text) {
      CustomSnackBar.showSnackBar(
          headerText: AppString.error.tr, bodyText: "Please Valid Otp Enter!");
    } else{
     await APIs.verifyOtpDriverApi(rideId: rideId);
     try {
       isSet.value=true;
       Directions? info;
       info = await DirectionsRepository().getDirections(
         origin: userLocation.value ?? LatLng(double.parse(data.pickupLatitude!),
             double.parse(data.pickupLongitude!)),
         destination: LatLng(double.parse(data.dropoffLatitude!),
             double.parse(data.dropoffLongitude!)),
       );

       if (info != null && info.polylinePoints.isNotEmpty) {
         List<LatLng> polylinePoints = info.polylinePoints.map((point) => LatLng(point.latitude, point.longitude)).toList();
         Polyline polyline = Polyline(
           polylineId: const PolylineId('route'),
           points: polylinePoints,
           color: Colors.blue,
           width: 5,
         );
         polylines.clear();
         polylines.add(polyline);
       } else {
         if (kDebugMode) {
           print("No valid polylinePoints found in the response.");
         }
       }
       pickupMarker.value.clear();
       pickupMarker.value.add(
         Marker(
           markerId: const MarkerId('destination_marker'),
           position: LatLng(double.parse(data.dropoffLatitude!),
               double.parse(data.dropoffLongitude!)),
           infoWindow: const InfoWindow(
             title: "Drop Point",
           ),
           icon: BitmapDescriptor.defaultMarker,
         ),
       );
       update();
       isSet.value=false;
     } catch (e) {
       print("Error $e");
     }
     Future.delayed(const Duration(seconds: 2)).then((value) => Get.close(1)); // Close the bottom sheet
    }
  }

  onMapSet() async {
    try {
      isSet.value=true;
      Directions? info;
      info = await DirectionsRepository().getDirections(
        origin: userLocation.value ?? LatLng(double.parse(data.pickupLatitude!),
            double.parse(data.pickupLongitude!)),
        destination: LatLng(double.parse(data.pickupLatitude!),
            double.parse(data.pickupLongitude!)),
      );

      if (info != null && info.polylinePoints.isNotEmpty) {
        List<LatLng> polylinePoints = info.polylinePoints.map((point) => LatLng(point.latitude, point.longitude)).toList();
        Polyline polyline = Polyline(
          polylineId: const PolylineId('route'),
          points: polylinePoints,
          color: Colors.blue,
          width: 5,
        );
        polylines.clear();
        polylines.add(polyline);
      } else {
        if (kDebugMode) {
          print("No valid polylinePoints found in the response.");
        }
      }
      pickupMarker.value.clear();
      pickupMarker.value.add(
        Marker(
          markerId: const MarkerId('destination_marker'),
          position: LatLng(double.parse(data.pickupLatitude!),
              double.parse(data.pickupLongitude!)),
          infoWindow: const InfoWindow(
            title: "Pickup Point",
          ),
          icon: BitmapDescriptor.defaultMarker,
        ),
      );
      update();
      isSet.value=false;
    } catch (e) {
      print("Error $e");
    }
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
  Future<void> onSubmit()async{
  await APIs.rideComplateApi(rideId: data.rideId!).then((value) =>  Get.offAndToNamed(
      AppRoutes.homeScreenRoutes));
  
  }
}
