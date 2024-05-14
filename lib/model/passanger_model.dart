class RideHistoryItemPass {
  final int rideId;
  final String driverId;
  final String status;
  final String pickupLocation;
  final String pickupLocationSubText;
  final String dropoffLocation;
  final String dropLocationSubText;
  final double amount;
  final String date;
  final String rideConfirmedAt;
  final String completedTime;

  RideHistoryItemPass({
    required this.rideId,
    required this.driverId,
    required this.status,
    required this.pickupLocation,
    required this.pickupLocationSubText,
    required this.dropoffLocation,
    required this.dropLocationSubText,
    required this.amount,
    required this.date,
    required this.rideConfirmedAt,
    required this.completedTime,
  });

  factory RideHistoryItemPass.fromJson(Map<String, dynamic> json) {
    return RideHistoryItemPass(
      rideId: json['ride_id'],
      driverId: json['driver_id'] ?? '',
      status: json['status'],
      pickupLocation: json['pickup_location'],
      pickupLocationSubText: json['pickup_location_sub_text'],
      dropoffLocation: json['dropoff_location'],
      dropLocationSubText: json['drop_location_sub_text'],
      amount: double.parse(json['amount']),
      date: json['date'],
      rideConfirmedAt: json['ride_confirmed_at'] ?? '',
      completedTime: json['completed time'] ?? '',
    );
  }
}
