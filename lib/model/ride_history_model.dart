class RideHistory {
  final List<RideItem> rideHistory;

  RideHistory({required this.rideHistory});

  factory RideHistory.fromJson(Map<String, dynamic> json) {
    List<RideItem> rides = [];
    if (json['ride_history'] != null) {
      rides = List<RideItem>.from(
          json['ride_history'].map((ride) => RideItem.fromJson(ride)));
    }
    return RideHistory(rideHistory: rides);
  }
}

class RideItem {
  final int rideId;
  final String driverId;
  final DriverDetails driverDetails;
  final int passengerId;
  final PassengerDetails passengerDetails;
  final String status;
  final String pickupLocation;
  final String pickupLocationSubText;
  final String dropoffLocation;
  final String dropLocationSubText;
  final String amount;
  final String distance;
  final String date;
  final String rideConfirmedAt;
  final String completedTime;

  RideItem({
    required this.rideId,
    required this.driverId,
    required this.driverDetails,
    required this.passengerId,
    required this.passengerDetails,
    required this.status,
    required this.pickupLocation,
    required this.pickupLocationSubText,
    required this.dropoffLocation,
    required this.dropLocationSubText,
    required this.amount,
    required this.distance,
    required this.date,
    required this.rideConfirmedAt,
    required this.completedTime,
  });

  factory RideItem.fromJson(Map<String, dynamic> json) {
    return RideItem(
      rideId: json['ride_id'] ?? 0,
      driverId: json['driver_id'] ?? '',
      driverDetails: DriverDetails.fromJson(json['driver_details']),
      passengerId: json['passenger_id'] ?? 0,
      passengerDetails: PassengerDetails.fromJson(json['passenger_details']),
      status: json['status'] ?? '',
      pickupLocation: json['pickup_location'] ?? '',
      pickupLocationSubText: json['pickup_location_sub_text'] ?? '',
      dropoffLocation: json['dropoff_location'] ?? '',
      dropLocationSubText: json['drop_location_sub_text'] ?? '',
      amount: json['amount'] ?? '',
      distance: json['distance'] ?? '',
      date: json['date'] ?? '',
      rideConfirmedAt: json['ride_confirmed_at'] ?? '',
      completedTime: json['completed time'] ?? '',
    );
  }
}

class DriverDetails {
  final String driverName;
  final String driverPhoto;
  final String vehicleNumber;

  DriverDetails({
    required this.driverName,
    required this.driverPhoto,
    required this.vehicleNumber,
  });

  factory DriverDetails.fromJson(Map<String, dynamic> json) {
    return DriverDetails(
      driverName: json['driver name'] ?? '',
      driverPhoto: json['driver_photo'] ?? '',
      vehicleNumber: json['vehicle_number'] ?? '',
    );
  }
}

class PassengerDetails {
  final String passengerName;
  final String mobileNumber;

  PassengerDetails({
    required this.passengerName,
    required this.mobileNumber,
  });

  factory PassengerDetails.fromJson(Map<String, dynamic> json) {
    return PassengerDetails(
      passengerName: json['passenger_name'] ?? '',
      mobileNumber: json['mobile_number'] ?? '',
    );
  }
}
