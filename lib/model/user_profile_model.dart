  // To parse this JSON data, do
//
//     final userProfileModel = userProfileModelFromJson(jsonString);

import 'dart:convert';

UserProfileModel userProfileModelFromJson(String str) => UserProfileModel.fromJson(json.decode(str));

String userProfileModelToJson(UserProfileModel data) => json.encode(data.toJson());

  class UserProfileModel {
    final User? user;
    final User2? user2; // Add this line to include User2
    final String? success;
    final String? token;
    final String? status;

    UserProfileModel({
      this.token, this.status,
      this.user,
      this.user2, // Add this line to include User2
      this.success,
    });

    factory UserProfileModel.fromJson(Map<String, dynamic> json) => UserProfileModel(
        user: json["user"] == null
            ? null
            : (json["status"].toString() == "1"
            ? User.fromJson(json["user"])
            : null), // Set user to null when status is not equal to "1"
        user2: json["user"] == null
            ? null
            : (json["status"].toString() == "2"
            ? User2.fromJson(json["user"])
            : null), // Add this line to include User2
        success: json["success"],
        token: json["token"],
        status: json["status"]
    );

    Map<String, dynamic> toJson() => {
      "user": user?.toJson(),
      "user2": user2?.toJson(), // Add this line to include User2
      "success": success,
    };
  }

class User {
  final int? id;
  final String? vehicleNumber;
  final String? licenceNumber;
  final String? driverPhoto;
  final String? vehiclePhotoFront;
  final String? vehiclePhotoBack;
  final String? driverName;
  final String? email;
  final String? mobileNumber;
  final String? password;
  final String? adaharNumber;
  final String? aadharPhotoFront;
  final String? aadharPhotoBack;
  final String? address;
  final String? pincode;
  final String? referalCode;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  User({
    this.id,
    this.vehicleNumber,
    this.licenceNumber,
    this.driverPhoto,
    this.vehiclePhotoFront,
    this.vehiclePhotoBack,
    this.driverName,
    this.email,
    this.mobileNumber,
    this.password,
    this.adaharNumber,
    this.aadharPhotoFront,
    this.aadharPhotoBack,
    this.address,
    this.pincode,
    this.referalCode,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"]??0,
    vehicleNumber: json["vehicle_number"]??'',
    licenceNumber: json["licence_number"]??'',
    driverPhoto: json["driver_photo"]??"",
    vehiclePhotoFront: json["vehicle_photo_front"]??'',
    vehiclePhotoBack: json["vehicle_photo_back"]??'',
    driverName: json["driver_name"]??"",
    email: json["email"]??"",
    mobileNumber: json["mobile_number"]??"",
    password: json["password"]??'',
    adaharNumber: json["adahar_number"]??"",
    aadharPhotoFront: json["aadhar_photo_front"]??"",
    aadharPhotoBack: json["aadhar_photo_back"]??"",
    address: json["address"]??'',
    pincode: json["pincode"]??"",
    referalCode: json["referal_code"]??"",
    status: json["status"]??'',
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "vehicle_number": vehicleNumber,
    "licence_number": licenceNumber,
    "driver_photo": driverPhoto,
    "vehicle_photo_front": vehiclePhotoFront,
    "vehicle_photo_back": vehiclePhotoBack,
    "driver_name": driverName,
    "email": email,
    "mobile_number": mobileNumber,
    "password": password,
    "adahar_number": adaharNumber,
    "aadhar_photo_front": aadharPhotoFront,
    "aadhar_photo_back": aadharPhotoBack,
    "address": address,
    "pincode": pincode,
    "referal_code": referalCode,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
  class User2 {
    final int id;
    final String fullName;
    final String mobileNumber;
    final String email;
    final String password;
    final String address;
    final dynamic pincode;
    final dynamic profilePicture;
    final String referalCode;
    final String status;
    final String pushNotification;
    final DateTime createdAt;
    final DateTime updatedAt;

    User2({
      required this.id,
      required this.fullName,
      required this.mobileNumber,
      required this.email,
      required this.password,
      required this.address,
      required this.pincode,
      required this.profilePicture,
      required this.referalCode,
      required this.status,
      required this.pushNotification,
      required this.createdAt,
      required this.updatedAt,
    });

    factory User2.fromJson(Map<String, dynamic> json) => User2(
      id: json["id"]??0,
      fullName: json["full_name"]??'',
      mobileNumber: json["mobile_number"]??'',
      email: json["email"]??'',
      password: json["password"]??'',
      address: json["address"]??'',
      pincode: json["pincode"]??"",
      profilePicture: json["profile_picture"]??"",
      referalCode: json["referal_code"]??"",
      status: json["status"]??"",
      pushNotification: json["push_notification"]??'',
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
      "id": id,
      "full_name": fullName,
      "mobile_number": mobileNumber,
      "email": email,
      "password": password,
      "address": address,
      "pincode": pincode,
      "profile_picture": profilePicture,
      "referal_code": referalCode,
      "status": status,
      "push_notification": pushNotification,
      "created_at": createdAt.toIso8601String(),
      "updated_at": updatedAt.toIso8601String(),
    };
  }