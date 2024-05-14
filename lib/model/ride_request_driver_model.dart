class RideRequestDriver {
  final int? passengerId;
  final String? pickupLatitude;
  final String? pickupLongitude;
  final String? dropoffLatitude;
  final String? dropoffLongitude;
  final String? pickupLocationMainText;
  final String? pickupLocationSubText;
  final String? dropLocationMainText;
  final String? dropLocationSubText;
  final String? distance;
  final String? price;
  final String? passengerMobileNo;
  final String? status; // Update status to be nullable
  final String? rideId;
  final String? createdAt;
  final String? updatedAt;
  final String? pushNotification;

  RideRequestDriver({
    required this.passengerId,
    required this.pickupLatitude,
    required this.pickupLongitude,
    required this.dropoffLatitude,
    required this.dropoffLongitude,
    required this.pickupLocationMainText,
    required this.pickupLocationSubText,
    required this.dropLocationMainText,
    required this.dropLocationSubText,
    required this.distance,
    required this.price,
    required this.passengerMobileNo,
    required this.status,
    required this.rideId,
    required this.createdAt,
    required this.updatedAt,
    required this.pushNotification,
  });

  factory RideRequestDriver.fromJson(Map<String, dynamic> json) {
    return RideRequestDriver(
      passengerId: json['passenger_id']??0,
      pickupLatitude: json['pickup_latitude']??'',
      pickupLongitude: json['pickup_longitude']??"",
      dropoffLatitude: json['dropoff_latitude']??"",
      dropoffLongitude: json['dropoff_longitude']??'',
      pickupLocationMainText: json['pickup_location_main_text']??"",
      pickupLocationSubText: json['pickup_location_sub_text']??"",
      dropLocationMainText: json['drop_location_main_text']??"",
      dropLocationSubText: json['drop_location_sub_text']??"",
      distance: json['distance']??"",
      price: json['price']??'',
      passengerMobileNo: json['passenger_mobile_no']??"",
      status: json['status']??"",
      rideId: json['ride_id']??"",
      createdAt: json['created_at']??"",
      updatedAt: json['updated_at']??"",
      pushNotification: json['push_notification']??"",
    );
  }
}

class RideRequestList {
  final bool success;
  final List<RideRequestDriver> rideRequests;

  RideRequestList({
    required this.success,
    required this.rideRequests,
  });

  factory RideRequestList.fromJson(Map<String, dynamic> json) {
    return RideRequestList(
      success: json['success'],
      rideRequests: List<RideRequestDriver>.from(
          json['ride_requests'].map((x) => RideRequestDriver.fromJson(x))),
    );
  }
}
