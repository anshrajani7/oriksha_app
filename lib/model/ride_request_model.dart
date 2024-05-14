class RideRequest {
  final bool success;
  final String message;
  final int rideId;

  final List<Ride> rides;

  RideRequest( {
   required this.rideId,
    required this.success,
    required this.message,
    required this.rides,
  });

  factory RideRequest.fromJson(Map<String, dynamic> json) {
    return RideRequest(
      success: json['success'],
      message: json['message'],
      rideId: json['ride_id'],
      rides: List<Ride>.from(json['drivers'].map((ride) => Ride.fromJson(ride))),
    );
  }
}

class Ride {
  final int driverId;
  final String pushNotification;

  Ride({
    required this.driverId,
    required this.pushNotification,
  });

  factory Ride.fromJson(Map<String, dynamic> json) {
    return Ride(
      driverId: json['driver_id'],
      pushNotification: json['push_notification'],
    );
  }
}
