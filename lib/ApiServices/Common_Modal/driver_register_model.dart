class DriverList {
  dynamic success;
  String? token;
  DriverDetails? driverDetails;

  DriverList({
    this.success,
    this.token,
    this.driverDetails,
  });

  factory DriverList.fromJson(Map<String, dynamic> json) {
    return DriverList(
      success: json['success'],
      token: json['token'],
      driverDetails: json['driver'] != null
          ? DriverDetails.fromJson(json['driver'])
          : null,
    );
  }
}

class DriverDetails {
  String? vehicleNumber;
  String? licenceNumber;
  String? driverName;
  String? mobileNumber;
  String? email;
  String? password;
  String? adharNumber;
  String? referralCode;
  String? driverPhoto;
  String? vehiclePhotoFront;
  String? vehiclePhotoBack;
  String? adharPhotoFront;
  String? adharPhotoBack;
  String? status;
  String? id;
  String? pushToken;

  DriverDetails({
    this.vehicleNumber,
    this.licenceNumber,
    this.driverName,
    this.mobileNumber,
    this.email,
    this.password,
    this.adharNumber,
    this.referralCode,
    this.driverPhoto,
    this.vehiclePhotoFront,
    this.vehiclePhotoBack,
    this.adharPhotoFront,
    this.adharPhotoBack,
    this.status,
    this.pushToken,
    this.id
  });

  factory DriverDetails.fromJson(Map<String, dynamic> json) {
    return DriverDetails(
      vehicleNumber: json['vehicle_number']??"",
      licenceNumber: json['licence_number']??"",
      driverName: json['driver_name']??"",
      mobileNumber: json['mobile_number']??"",
      email: json['email']??"",
      password: json['password']??'',
      adharNumber: json['adahar_number']??'',
      referralCode: json['referal_code']??"",
      driverPhoto: json['driver_photo']??"",
      vehiclePhotoFront: json['vehicle_photo_front']??"",
      vehiclePhotoBack: json['vehicle_photo_back']??"",
      adharPhotoFront: json['aadhar_photo_front']??"",
      adharPhotoBack: json['aadhar_photo_back']??"",
      status: json['status'].toString(),
      id: json['id'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'vehicle_number': vehicleNumber,
      'licence_number': licenceNumber,
      'driver_name': driverName,
      'mobile_number': mobileNumber,
      'email': email,
      'password': password,
      'adahar_number': adharNumber,
      'referal_code': referralCode,
      'driver_photo': driverPhoto,
      'vehicle_photo_front': vehiclePhotoFront,
      'vehicle_photo_back': vehiclePhotoBack,
      'aadhar_photo_front': adharPhotoFront,
      'aadhar_photo_back': adharPhotoBack,
      'status': status,
      'push_notification': pushToken,
    };
    return data;
  }
}
