class Driver {
final int userId;
final String latitude;
final String longitude;
final double distance;

Driver({
  required this.userId,
  required this.latitude,
  required this.longitude,
  required this.distance,
});

factory Driver.fromJson(Map<String, dynamic> json) {
return Driver(
userId: json['user_id'],
latitude: json['latitude'],
longitude: json['longitude'],
distance: json['distance'].toDouble(),
);
}
}

class AllDriversResponse {
final bool success;
final List<Driver> drivers;

AllDriversResponse({
required this.success,
required this.drivers,
});

factory AllDriversResponse.fromJson(Map<String, dynamic> json) {
return AllDriversResponse(
success: json['success'],
drivers: List<Driver>.from(json['drivers'].map((driver) => Driver.fromJson(driver))),
);
}
}