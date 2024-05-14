class Transaction {
  final int? id;
  final int? driverId;
  final int? passangerId;
  final String? type;
  final String? amount;
  final String? createdAt;
  final String? updatedAt;

  Transaction( {
    this.passangerId,
    required this.id,
    required this.driverId,
    required this.type,
    required this.amount,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id']??0,
      passangerId:json['passenger_id']??0,
      driverId: json['driver_id']??0,
      type: json['type']??"",
      amount: json['amount']??'',
      createdAt: json['created_at']??'',
      updatedAt: json['updated_at']??'',
    );
  }
}
