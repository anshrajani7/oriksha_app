class RideRequestResponse {
  final String success;
  final DriverDetailsData driverDetails;

  RideRequestResponse({
    required this.success,
    required this.driverDetails,
  });

  factory RideRequestResponse.fromJson(Map<String, dynamic> json) {
    return RideRequestResponse(
      success: json['success'],
      driverDetails: DriverDetailsData.fromJson(json['driver_details']),
    );
  }
}

class DriverDetailsData {
  final int? driverId;
  final String? driverName;
  final String? driverLatitude;
  final String? driverLongitude;
  final String? driverMobileNumber;
  final String? otp;

  DriverDetailsData({
    required this.driverId,
    required this.driverName,
    required this.driverLatitude,
    required this.driverLongitude,
    required this.driverMobileNumber,
    required this.otp,
  });

  factory DriverDetailsData.fromJson(Map<String, dynamic> json) {
    return DriverDetailsData(
      driverId: json['driver_id']??0,
      driverName: json['driver_name']??'',
      driverLatitude: json['driver_latitude']??"",
      driverLongitude: json['driver_longitude']??"",
      driverMobileNumber: json['driver_mobile_number']??"",
      otp: json['otp']??"",
    );
  }
}
