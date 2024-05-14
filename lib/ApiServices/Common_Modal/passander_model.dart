class UserData {
  String fullName;
  String mobileNumber;
  String password;
  String email;
  String address;
  String referalCode;
  String pushToken;

  UserData({
    required this.fullName,
    required this.mobileNumber,
    required this.password,
    required this.email,
    required this.address,
    required this.referalCode,
    required this.pushToken,
  });

  Map<String, dynamic> toJson() {
    return {
      "full_name": fullName,
      "mobile_number": mobileNumber,
      "password": password,
      "email": email,
      "address": address,
      "referal_code": referalCode,
      "push_notification": pushToken,
    };
  }
}
class PassengerData {
  String fullName;
  String mobileNumber;
  String email;
  String password;
  String? address;
  String? referalCode;
  int status;
  String updatedAt;
  String createdAt;
  int id;

  PassengerData({
    required this.fullName,
    required this.mobileNumber,
    required this.email,
    required this.password,
    required this.address,
    required this.referalCode,
    required this.status,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory PassengerData.fromJson(Map<String, dynamic> json) {
    return PassengerData(
      fullName: json['full_name'],
      mobileNumber: json['mobile_number'],
      email: json['email'],
      password: json['password'],
      address: json['address']??'',
      referalCode: json['referal_code'],
      status: json['status'],
      updatedAt: json['updated_at'],
      createdAt: json['created_at'],
      id: json['id'],
    );
  }
}

class ApiResponse {
  String token;
  PassengerData passenger;
  String success;

  ApiResponse({
    required this.token,
    required this.passenger,
    required this.success,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      token: json['token'],
      passenger: PassengerData.fromJson(json['passenger']),
      success: json['success'],
    );
  }
}
