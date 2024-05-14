import 'dart:convert';
import 'package:oriksha_application/ApiServices/api_services.dart';
import 'package:oriksha_application/presentation/DashBord_Page/controller/dashbord_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../ApiServices/network_utils.dart';
import '../../../core/app_export.dart';
import '../../../model/Location_Model/destination_model.dart';

class SerchScreenController extends GetxController {
  DashBordScreenController controller = Get.find<DashBordScreenController>();
  final FocusNode dropFocusNode = FocusNode();
  RxBool isSetMap= false.obs;
  @override
  void onInit() {
    pickupController.text=controller.pickupLocation.value;
    dropController.text=controller.dropLocation.value;
    super.onInit();
  }
  String pickMain='';
  String pickSub='';
  String dropMain='';
  String dropSub='';
  TextEditingController pickupController = TextEditingController();
  TextEditingController dropController = TextEditingController();
  RxBool pickup = false.obs;
  RxBool onTap = true.obs;
  double? pikupLat;
  double? pikupLag;
  double? dropLat;
  double? dropLag;
  var totalDuratin;
  var totalDistanse;
  final RxList places = [].obs;
  var name;
  var name1;
  String calculateTotalPrice(String totalDistanceString) {
    // Assuming the price per kilometer is 18 rupees
    double pricePerKilometer = 19.50;

    // Extract numeric value from the string and convert it to double
    double totalDistance = double.parse(totalDistanceString.split(' ')[0]);

    // Calculate the total price
    double totalPrice = totalDistance * pricePerKilometer;
    String formattedTotalPrice = totalPrice.toStringAsFixed(2);

    return formattedTotalPrice;
    // Update the controller or use the value as needed
  }

// Example usage with a total distance string "5.0 km"


  void placeAutocomplete(String query, TextEditingController controller) async {
    final Uri uri =
        Uri.https("maps.googleapis.com", 'maps/api/place/autocomplete/json', {
      "input": query,
      "key": 'AIzaSyC0Fig5YC1Yy__X4TOvKG8aH40FKnMFWzY',
    });

    places.clear();
    final String? response = await NetworkUtility.fetchUrl(uri);
    places.value = jsonDecode(response!)['predictions'];
  }

  Future<void> handlePlaceSelection(int index) async {
    try {
      final Uri detailsUri =
          Uri.https("maps.googleapis.com", 'maps/api/place/details/json', {
        "place_id": places[index]['place_id'].toString(),
        "key": 'AIzaSyC0Fig5YC1Yy__X4TOvKG8aH40FKnMFWzY',
      });

      final String? detailsResponse = await NetworkUtility.fetchUrl(detailsUri);
      final detailsData = jsonDecode(detailsResponse!)['result'];
      if (kDebugMode) {
        print(detailsData.toString());
      }

      if (pickup.isTrue) {
        pickMain=places[index]['structured_formatting']
        ['main_text'];
        pickSub= places[index]['structured_formatting']['secondary_text'];
        pickupController.text = places[index]['structured_formatting']
                ['main_text'] +
            ', ' +
            places[index]['structured_formatting']['secondary_text'];
        pikupLat = detailsData['geometry']['location']['lat'];
        pikupLag = detailsData['geometry']['location']['lng'];
        name = detailsData['name'];
      } else {
        dropMain=places[index]['structured_formatting']
        ['main_text'];
        dropSub= places[index]['structured_formatting']['secondary_text'];
        dropController.text = places[index]['structured_formatting']
                ['main_text'] +
            ', ' +
            places[index]['structured_formatting']['secondary_text'];
        onTap.value = false;
        dropLat = detailsData['geometry']['location']['lat'];
        dropLag = detailsData['geometry']['location']['lng'];
        name1 = detailsData['name'];
      }
      places.clear();
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
    }
  }

  onMapSet() async {
    isSetMap.value=true;
    Directions? info;
    info = await DirectionsRepository().getDirections(
      origin: LatLng(pikupLat??controller.pikLat, pikupLag??controller.pikLong),
      destination: LatLng(dropLat!, dropLag!),
    );

    if (info != null && info.polylinePoints.isNotEmpty) {
      List<LatLng> polylinePoints = info.polylinePoints
          .map((point) => LatLng(point.latitude, point.longitude))
          .toList();
      totalDistanse = info.totalDistance;
      totalDuratin = info.totalDuration;
      Polyline polyline = Polyline(
        polylineId: const PolylineId('route'),
        points: polylinePoints,
        color: Colors.blue,
        width: 5,
      );

      controller.polylines.clear();
      controller.polylines.add(polyline);
    } else {
      if (kDebugMode) {
        print("No valid polylinePoints found in the response.");
      }
    }
    controller.markers.value.add(
      Marker(
        markerId: const MarkerId('destination_marker'),
        position: LatLng(dropLat!, dropLag!),
        infoWindow: const InfoWindow(title: "Drop Point",),
        icon: BitmapDescriptor.fromBytes(APIs.markerIcons[2]),
      ),
    );
    controller.markers.value.add(
      Marker(
        markerId: const MarkerId('pickup_marker'),
        position: LatLng(pikupLat??controller.pikLat, pikupLag??controller.pikLong),
        infoWindow: const InfoWindow(title: "Pickup Point"),
        icon: BitmapDescriptor.fromBytes(APIs.markerIcons[1]),
      ),

    );

    try {
      LatLngBounds bounds = LatLngBounds(
        southwest: LatLng(
          (pikupLat ?? controller.pikLat) < dropLat! ? (pikupLat ?? controller.pikLat ) : dropLat!,
          (pikupLag ?? controller.pikLong) < dropLag! ? (pikupLag ?? controller.pikLong ) : dropLag!,
        ),
        northeast: LatLng(
          (pikupLat ?? controller.pikLat ) > dropLat! ? (pikupLat ?? controller.pikLat) : dropLat!,
          (pikupLag ?? controller.pikLong ) > dropLag! ? (pikupLag ?? controller.pikLong) : dropLag!,
        ),
      );
      // Your existing code...
      await controller.mapController.value?.animateCamera(
        CameraUpdate.newLatLngBounds(bounds, 50),
      );
      // Your existing code...
    } catch (e) {
      if (kDebugMode) {
        print("Error animating camera: $e");
      }
    }
    controller.openBootmSheet.value = true;
    APIs.bottomSheet.value=true;
    controller.pikLat=pikupLat??controller.pikLat;
    controller.pikLong=pikupLag??controller.pikLong;
    controller.dropLat=dropLat??controller.dropLat;
    controller.dropLong=dropLag??controller.pikLong;
    controller.pickupLocation.value = pickupController.text;
    controller.dropLocation.value = dropController.text;
    controller.totalDuration.value = totalDuratin;
    if(controller.pickup_main.isEmpty){
      controller.pickup_main.value=pickMain;
      controller.pickup_text.value=pickSub;
    }
    controller.dropLocation_main.value=dropMain;
    controller.dropLocation_sub.value=dropSub;
    controller.totalDistance.value= totalDistanse;
    controller.totalPrice.value=calculateTotalPrice(totalDistanse);
    isSetMap.value=false;
  Future.delayed(Duration(seconds: 2)).then((value) =>   Get.back());
  }
}
