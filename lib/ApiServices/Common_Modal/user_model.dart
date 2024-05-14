class User {
  final int id;
  final String vehicleNumber;
  final String licenceNumber;
  final String driverPhoto;
  final String vehiclePhotoFront;
  final String vehiclePhotoBack;
  final String driverName;
  final String email;
  final String mobileNumber;
  final String password;
  final String aadharNumber;
  final String aadharPhotoFront;
  final String aadharPhotoBack;
  final String address;
  final String pincode;
  final String referralCode;
  final String status;
  final String pushNotification;
  final String createdAt;
  final String updatedAt;

  User({
    required this.id,
    required this.vehicleNumber,
    required this.licenceNumber,
    required this.driverPhoto,
    required this.vehiclePhotoFront,
    required this.vehiclePhotoBack,
    required this.driverName,
    required this.email,
    required this.mobileNumber,
    required this.password,
    required this.aadharNumber,
    required this.aadharPhotoFront,
    required this.aadharPhotoBack,
    required this.address,
    required this.pincode,
    required this.referralCode,
    required this.status,
    required this.pushNotification,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['user']['id']??"",
      vehicleNumber: json['user']['vehicle_number']??"",
      licenceNumber: json['user']['licence_number']??"",
      driverPhoto: json['user']['driver_photo']??"",
      vehiclePhotoFront: json['user']['vehicle_photo_front']??"",
      vehiclePhotoBack: json['user']['vehicle_photo_back']??"",
      driverName: json['user']['driver_name']??"",
      email: json['user']['email']??"",
      mobileNumber: json['user']['mobile_number']??"",
      password: json['user']['password']??"",
      aadharNumber: json['user']['adahar_number']??'',
      aadharPhotoFront: json['user']['aadhar_photo_front']??"",
      aadharPhotoBack: json['user']['aadhar_photo_back']??"",
      address: json['user']['address']??"",
      pincode: json['user']['pincode']??"",
      referralCode: json['user']['referal_code']??"",
      status: json['user']['status']??"",
      pushNotification: json['user']['push_notification']??"",
      createdAt: json['user']['created_at']??"",
      updatedAt: json['user']['updated_at']??"",
    );
  }
}
