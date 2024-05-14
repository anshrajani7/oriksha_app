import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:dio/dio.dart' as dios;
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image/image.dart' as img;
import 'package:oriksha_application/ApiServices/Common_Modal/Network_info.dart';
import 'package:oriksha_application/ApiServices/Common_Modal/driver_register_model.dart' as driverModel;
import 'package:oriksha_application/ApiServices/Common_Modal/passander_model.dart';
import 'package:oriksha_application/core/Utils/common_constor.dart';
import 'package:oriksha_application/core/Utils/hive_keys.dart';
import 'package:oriksha_application/core/Utils/network_url.dart';
import 'package:oriksha_application/core/services/notification_services.dart';
import 'package:oriksha_application/model/driver_data_model.dart';
import 'package:oriksha_application/model/ride_request_model.dart';

import '../core/app_export.dart';
import '../model/passanger_model.dart';
import '../model/ride_history_model.dart';
import '../model/ride_request_driver_model.dart';
import '../model/send_ride_request_model.dart';
import '../model/transation_model.dart';
import '../model/user_profile_model.dart';

class APIs extends GetConnect {
  static const String passanger = "2";
  static const String driver = "1";
  static final Dio dio = Dio();
  static RxBool isApiLoading = false.obs;
  static RxBool isLocationUpadate = true.obs;
  static RxBool isLoading = false.obs;
  static FirebaseStorage storage = FirebaseStorage.instance;
  static FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  static Set<Marker> markers = {};
  static RxString amount = "00".obs;
  static RxString lockAmount = "00".obs;
  static var accept = 'application/json';
  static String image = '';
  static String image1 = '';
  static String image2 = '';
  static String image3 = '';
  static String image4 = '';
  static RxBool rideConfirm = false.obs;
  static RxBool bottomSheet = false.obs;
  static RxBool timeStart = false.obs;
  static RxBool rideArrive = false.obs;
  static String emptyImage =
      'https://pbs.twimg.com/profile_images/1321030814436655106/87OcbZNm_400x400.jpg';
  static RxInt otpCord = 0.obs;
  static var contentType = 'application/x-www-form-urlencoded';
  static var headers = {
    'Accept': accept,
    'Content-Type': contentType,
  };
  static final List<String> markerImages = [
    'assets/icons/riksha.png',
    'assets/icons/pickupMarker.png',
    'assets/icons/dropMarker.png',
    'assets/icons/usericon.png',
  ];
  static List<Uint8List> markerIcons = [];

  static Future<void> onLoadImage() async {
    for (int i = 0; i < markerImages.length; i++) {
      markerIcons.add(await getBytesFromAssets(markerImages[i], 70));
    }
  }

  static Future<Uint8List> getBytesFromAssets(String path, int width) async {
    final ByteData data = await rootBundle.load(path);
    final ui.Codec codec = await ui
        .instantiateImageCodec(data.buffer.asUint8List(), targetHeight: width);
    final ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  static Future<String?> getToken() async {
    await firebaseMessaging.requestPermission();
    String? token = await firebaseMessaging.getToken();
    return token!;
  }

  static File compressImage(File imageFile) {
    img.Image? imageC = img.decodeImage(imageFile.readAsBytesSync());
    final compressedImage = File('${imageFile.path}.jpg')
      ..writeAsBytesSync(img.encodeJpg(imageC!, quality: 50));
    return compressedImage;
  }

  static Future<void> vehiclePhotoAdd({
    required File vehicalFrontPhoto,
    required File vehiclePhoBack,
    required File driverPhoto,
    required String vehicleNumber,
  }) async {
    try {
      bool connection = await NetworkInfo.checkNetwork();
      if (connection) {
        isApiLoading.value = true;
        isLoading.value = false;
        // Compress images using the compute function
        final vehicalFrontPhotoCom =
            await compute(compressImage, vehicalFrontPhoto);
        final vehiclePhoBackCom = await compute(compressImage, vehiclePhoBack);
        final driverPhotoCom = await compute(compressImage, driverPhoto);

        final ext = vehicalFrontPhotoCom.path.split('.').last;
        final ref =
            storage.ref().child('vehicle_photo(Front)/$vehicleNumber.$ext');

        final ext1 = vehiclePhoBackCom.path.split('.').last;
        final ref1 =
            storage.ref().child('vehicle_photo(Back)/$vehicleNumber.$ext1');

        final ext2 = driverPhotoCom.path.split('.').last;
        final ref2 = storage.ref().child('Driver_Photo/$vehicleNumber.$ext2');

        // Parallelize the image uploads
        await Future.wait([
          ref.putFile(vehicalFrontPhotoCom,
              SettableMetadata(contentType: 'image/$ext')),
          ref1.putFile(
              vehiclePhoBackCom, SettableMetadata(contentType: 'image/$ext1')),
          ref2.putFile(
              driverPhotoCom, SettableMetadata(contentType: 'image/$ext2')),
        ]);

        // Get download URLs after uploading
        image = await ref.getDownloadURL();
        image1 = await ref1.getDownloadURL();
        image2 = await ref2.getDownloadURL();

        isLoading.value = true;
      }
    } catch (e) {
      log('Error: $e');
    } finally {
      isApiLoading.value = false;
      isLoading.value = true;
    }
  }

  static Future<void> aadharPhotoAdd(
      {required File aadharPhotFront,
      required File aadharPhotBack,
      required String vehicleNumber}) async {
    try {
      bool connection = await NetworkInfo.checkNetwork();
      if (connection) {
        isApiLoading.value = true;
        // Compress images using the compute function
        final aadhharFrontPhotoCom =
            await compute(compressImage, aadharPhotFront);
        final aadhharPhoBackCom = await compute(compressImage, aadharPhotBack);

        final ext = aadhharFrontPhotoCom.path.split('.').last;
        final ref =
            storage.ref().child('Aadhaar_Photo(Front)/$vehicleNumber.$ext');

        final ext1 = aadhharPhoBackCom.path.split('.').last;
        final ref1 =
            storage.ref().child('Aadhaar_Photo(Back)/$vehicleNumber.$ext1');

        // Parallelize the image uploads
        await Future.wait([
          ref.putFile(aadhharFrontPhotoCom,
              SettableMetadata(contentType: 'image/$ext')),
          ref1.putFile(
              aadhharPhoBackCom, SettableMetadata(contentType: 'image/$ext1')),
        ]);

        // Get download URLs after uploading
        image3 = await ref.getDownloadURL();
        image4 = await ref1.getDownloadURL();
        isApiLoading.value = false;
      }
    } catch (e) {
      log('Error :$e');
    }
  }

  static Future<void> driverRegisterApi({
    required String email,
    required String password,
    required String aadharNum,
    required String refferlcode,
    required String driverName,
    required String mobileNum,
    required String vehicleNumber,
    required String licenceNumber,
  }) async {
    try {
      bool connection = await NetworkInfo.checkNetwork();
      if (connection) {
        isApiLoading.value = true;
        isLoading.value = false;

        // Repeat the same process for backPhoto and driverPhoto
        final body = driverModel.DriverDetails(
          email: email,
          password: password,
          adharNumber: aadharNum,
          adharPhotoBack: image4.isNotEmpty ? image4 : emptyImage,
          adharPhotoFront: image3.isNotEmpty ? image3 : emptyImage,
          driverName: driverName,
          driverPhoto: image2.isNotEmpty ? image2 : emptyImage,
          licenceNumber: licenceNumber,
          mobileNumber: mobileNum,
          referralCode: refferlcode,
          status: '1',
          vehicleNumber: vehicleNumber,
          vehiclePhotoBack: image1.isNotEmpty ? image1 : emptyImage,
          vehiclePhotoFront: image.isNotEmpty ? image : emptyImage,
          pushToken: await getToken(),
        );

        // Making the POST request
        final response = await dio.post(
          NetWorkUrl.driverRegisterUrl,
          data: body.toJson(),
          options: Options(
            headers: headers, // Add headers if needed
          ),
        );

        if (response.statusCode == 201) {
          log("RESPONSE :- ${response.data}");
          var apiResponse =  driverModel.DriverList.fromJson(response.data);

          if (apiResponse.success == "true") {
            var driverDetails = apiResponse.driverDetails;
            await Constant.instance.dbHelper.driver
                .put(HiveKeys.name, driverDetails!.driverName);
            await Constant.instance.dbHelper.driver
                .put(HiveKeys.email, driverDetails.email);
            await Constant.instance.dbHelper.driver
                .put(HiveKeys.mobileNumber, driverDetails.mobileNumber);
            await Constant.instance.dbHelper.driver.put(HiveKeys.status, 1);
            await Constant.instance.dbHelper.driver
                .put(HiveKeys.id, driverDetails.id);
            await Constant.instance.dbHelper.driver
                .put(HiveKeys.image, driverDetails.driverPhoto);
            await Constant.instance.dbHelper.driver
                .put(HiveKeys.token, apiResponse.token);
            await Constant.instance.dbHelper.driver
                .put(HiveKeys.isDriver, true);
            CustomSnackBar.showSnackBar(
                headerText: "Success",
                bodyText: "Your Account Register Successfully");
            isLoading.value = true;
          } else {
            if (kDebugMode) {
              print("Error : ${apiResponse.success.toString()}");
            }
            CustomSnackBar.showSnackBar(
                headerText: AppString.error.tr,
                bodyText:
                    response.data['message'] ?? "You are already registered");
            isLoading.value = false;
            isApiLoading.value = false;
          }
        } else {
          // Handle other status codes
          CustomSnackBar.showSnackBar(
              headerText: AppString.error.tr, bodyText: response.data['error']);
          isLoading.value = false;
          isApiLoading.value = false;
        }
      }
    } on DioException catch (e) {
      // Handle DioException
      if (e.response?.statusCode == 403) {
        CustomSnackBar.showSnackBar(
            headerText: AppString.error.tr,
            bodyText: e.response?.data['error'] ??
                'Forbidden. Please check your credentials.');
      } else {
        CustomSnackBar.showSnackBar(
            headerText: AppString.error.tr,
            bodyText: "An error occurred. Please try again later.");
      }
      isLoading.value = false;
      isApiLoading.value = false;
    } catch (e) {
      // Handle other exceptions
      if (kDebugMode) {
        print("Error: $e");
      }
      CustomSnackBar.showSnackBar(
          headerText: AppString.error.tr,
          bodyText: "An error occurred. Please try again later.");
      isApiLoading.value = false;
    } finally {
      isApiLoading.value = false;
    }
  }

  static Future<void> passengerRegisterApi({
    required String email,
    required String password,
    required String refferlcode,
    required String name,
    required String mobileNum,
  }) async {
    try {
      bool connection = await NetworkInfo.checkNetwork();
      if (connection) {
        isApiLoading.value = true;
        isLoading.value = false;
        final body = UserData(
            fullName: name,
            mobileNumber: mobileNum,
            password: password,
            email: email,
            address: "",
            referalCode: refferlcode.isEmpty ? "" : refferlcode,
            pushToken: await getToken() ?? "");
        // Making the POST request
        final response = await dio.post(NetWorkUrl.passengerRegisterUrl,
            data: body.toJson(), options: Options(headers: headers));
        if (response.statusCode == 201) {
          if (response.data['success'] == "true") {
            log("RESPONSE :- ${response.data}");
            ApiResponse apiResponse = ApiResponse.fromJson(response.data);
            await Constant.instance.dbHelper.passenger
                .put(HiveKeys.name, apiResponse.passenger.fullName);
            await Constant.instance.dbHelper.passenger
                .put(HiveKeys.email, apiResponse.passenger.email);
            await Constant.instance.dbHelper.passenger
                .put(HiveKeys.mobileNumber, apiResponse.passenger.mobileNumber);
            await Constant.instance.dbHelper.driver.put(HiveKeys.status, 2);
            await Constant.instance.dbHelper.passenger
                .put(HiveKeys.id, apiResponse.passenger.id);
            await Constant.instance.dbHelper.passenger
                .put(HiveKeys.token, apiResponse.token);
            await Constant.instance.dbHelper.driver
                .put(HiveKeys.isPassenger, true);
            CustomSnackBar.showSnackBar(
                headerText: "Success",
                bodyText: "Your Account Register Successfully");
            isLoading.value = true;
            isApiLoading.value = false;
          }
        } else {
          CustomSnackBar.showSnackBar(
              headerText: AppString.error.tr,
              bodyText: response.data['message'] ?? 'Register Failed');
          isLoading.value = false;
          isApiLoading.value = false;
        }
      }
    } on DioException catch (e) {
      // Handle DioException
      if (e.response?.statusCode == 403) {
        CustomSnackBar.showSnackBar(
            headerText: AppString.error.tr,
            bodyText: e.response?.data['error'] ??
                'Forbidden. Please check your credentials.');
        isLoading.value = false;
        isApiLoading.value = false;
      } else {
        CustomSnackBar.showSnackBar(
            headerText: AppString.error.tr,
            bodyText: "An error occurred. Please try again later.");
      }
      isLoading.value = false;
      isApiLoading.value = false;
    } catch (e) {
      // Handle other exceptions
      if (kDebugMode) {
        print("Error: $e");
      }
      CustomSnackBar.showSnackBar(
          headerText: AppString.error.tr,
          bodyText: "An error occurred. Please try again later.");
      isApiLoading.value = false;
    } finally {
      isApiLoading.value = false;
    }
  }

  static Future<void> loginApi({
    required String password,
    required String mobileNum,
  }) async {
    try {
      bool connection = await NetworkInfo.checkNetwork();
      if (connection) {
        isApiLoading.value = true;
        isLoading.value = false;

        final body = {
          "mobile_number": mobileNum,
          "password": password,
          "push_notification": await getToken() ?? "",
        };

        // Making the POST request
        final response = await dio.post(
          NetWorkUrl.loginUrl,
          data: body,
          options: Options(
            headers: headers,
          ),
        );
        if (response.statusCode == 201) {
          log("RESPONSE : ${response.data}");
          var userData = UserProfileModel.fromJson(response.data);
          if (response.data["status"] == "2") {
            await Constant.instance.dbHelper.passenger
                .put(HiveKeys.name, userData.user2?.fullName ?? '');
            await Constant.instance.dbHelper.passenger
                .put(HiveKeys.email, userData.user2?.email ?? '');
            await Constant.instance.dbHelper.passenger
                .put(HiveKeys.address, userData.user2?.address ?? '');
            await Constant.instance.dbHelper.passenger
                .put(HiveKeys.mobileNumber, userData.user2?.mobileNumber ?? "");
            await Constant.instance.dbHelper.driver.put(HiveKeys.status, 2);
            await Constant.instance.dbHelper.passenger
                .put(HiveKeys.id, userData.user2?.id ?? '');
            await Constant.instance.dbHelper.passenger
                .put(HiveKeys.token, userData.token ?? "");
            await Constant.instance.dbHelper.driver
                .put(HiveKeys.isPassenger, true);
          } else {
            var driverDetails = userData.user;
            await Constant.instance.dbHelper.driver
                .put(HiveKeys.name, driverDetails!.driverName);
            await Constant.instance.dbHelper.driver
                .put(HiveKeys.email, driverDetails.email);
            await Constant.instance.dbHelper.driver
                .put(HiveKeys.mobileNumber, driverDetails.mobileNumber);
            await Constant.instance.dbHelper.driver.put(HiveKeys.status, 1);
            await Constant.instance.dbHelper.driver
                .put(HiveKeys.id, driverDetails.id);
            await Constant.instance.dbHelper.driver
                .put(HiveKeys.image, driverDetails.driverPhoto);
            await Constant.instance.dbHelper.driver
                .put(HiveKeys.token, response.data['token']);
            await Constant.instance.dbHelper.driver
                .put(HiveKeys.isDriver, true);
          }
          // Access properties directly from the response data
          CustomSnackBar.showSnackBar(
            headerText: "Success",
            bodyText: "Your Account Login Successfully",
          );
          isApiLoading.value = false;
          isLoading.value = true;
// Assuming HiveKeys.driverData is the key you used when putting the data
        } else {
          // Handle other status codes
          CustomSnackBar.showSnackBar(
              headerText: AppString.error.tr,
              bodyText: "An error occurred. Please try again later.");
          isLoading.value = false;
          isApiLoading.value = false;
        }
      }
    } on DioException catch (e) {
      // Handle DioException
      if (e.response?.statusCode == 401) {
        CustomSnackBar.showSnackBar(
            headerText: AppString.error.tr,
            bodyText: "This Mobile Number is Not Register");
        isLoading.value = false;
        isApiLoading.value = false;
      } else {
        CustomSnackBar.showSnackBar(
            headerText: AppString.error.tr,
            bodyText: "An error occurred. Please try again later.");
      }
      isLoading.value = false;
      isApiLoading.value = false;
    } catch (e) {
      // Handle other exceptions
      if (kDebugMode) {
        print("Error: $e");
      }
      CustomSnackBar.showSnackBar(
          headerText: AppString.error.tr,
          bodyText: "An error occurred. Please try again later.");
      isLoading.value = false;
      isApiLoading.value = false;
    } finally {
      isApiLoading.value = false;
    }
  }

  static Future<void> sendOtpApi({
    required String mobileNum,
  }) async {
    try {
      bool connection = await NetworkInfo.checkNetwork();
      if (connection) {
        isApiLoading.value = true;
        isLoading.value = false;
        // Repeat the same process for backPhoto and driverPhoto
        final body = {'mobile_number': mobileNum};
        // Making the POST request
        final response = await dio.post(
          NetWorkUrl.sendOtpUrl,
          data: body,
          options: Options(
            headers: headers, // Add headers if needed
          ),
        );
        if (response.statusCode == 200) {
          log("RESPONSE :- ${response.data}");
          Map<String, dynamic> decodedResponse = jsonDecode(response.data);
          if (kDebugMode) {
            print('Success: ${decodedResponse['otp']}');
          }
          CustomSnackBar.showSnackBar(
              headerText: "Success",
              bodyText: "Otp Send Successfully $mobileNum");
          otpCord.value = decodedResponse['otp'];
        } else {
          log("Message ${response.data["error"]['message']}");
          CustomSnackBar.showSnackBar(
              headerText: AppString.error.tr,
              bodyText: response.data['error']['message'].toString());

          isLoading.value = false;
          isApiLoading.value = false;
        }
      }
    } catch (e) {
      if (kDebugMode) {
        log("Error: $e");
      }
      isApiLoading.value = false;
    } finally {
      isApiLoading.value = false;
    }
  }

  static Future<void> updateProfileApi({
    required String name,
    required String address,
    required String pincord,
    required File image,
  }) async {
    try {
      bool connection = await NetworkInfo.checkNetwork();
      if (connection) {
        isApiLoading.value = true;
        final profileImage = await compute(compressImage, image);
        final ext = profileImage.path.split('.').last;
        final ref = storage.ref().child('Profile_Photo/$name.$ext');
        await Future.wait([
          ref.putFile(
              profileImage, SettableMetadata(contentType: 'image/$ext')),
        ]);
        // Get download URLs after uploading
        var images = await ref.getDownloadURL();
        final id =
            await Constant.instance.dbHelper.passenger.get(HiveKeys.id) ??
                await Constant.instance.dbHelper.driver.get(HiveKeys.id) ??
                "";
        bool isDriver =
            await Constant.instance.dbHelper.driver.get(HiveKeys.isDriver) ??
                false;
        final data = {
          isDriver ? "driver_id" : "passenger_id": id,
          isDriver ? "driver_name" : "full_name": name,
          "address": address,
          "pincode": pincord,
          isDriver ? "driver_photo" : "profile_picture": images,
        };
        final response = await dio.post(
          isDriver
              ? NetWorkUrl.updateProfileDriverUrl
              : NetWorkUrl.updateProfilePassengerUrl,
          data: data, // Use formData instead of data
          options: Options(headers: headers),
        );
        log("RESPONSE :- ${response.data}");
        if (response.statusCode == 200) {
          if (response.data['success'] == true) {
            if (!isDriver) {
              await Constant.instance.dbHelper.passenger
                  .put(HiveKeys.name, name);
              await Constant.instance.dbHelper.passenger
                  .put(HiveKeys.address, address);
              await Constant.instance.dbHelper.passenger
                  .put(HiveKeys.image, images);
            } else {
              await Constant.instance.dbHelper.driver.put(HiveKeys.name, name);
              await Constant.instance.dbHelper.driver
                  .put(HiveKeys.image, images);
            }
            CustomSnackBar.showSnackBar(
              headerText: "Success",
              bodyText: response.data['message'].toString(),
            );
          }
        } else {
          CustomSnackBar.showSnackBar(
            headerText: AppString.error.tr,
            bodyText: response.data['error']['message'].toString(),
          );
        }
      }
    } on DioException catch (e) {
      // Handle DioException
      if (e.response?.statusCode == 400) {
        log("${e.response?.data}");
        CustomSnackBar.showSnackBar(
          headerText: AppString.error.tr,
          bodyText: e.response?.data['error'] ?? 'Server Error',
        );
      } else {
        CustomSnackBar.showSnackBar(
          headerText: AppString.error.tr,
          bodyText: "An error occurred. Please try again later.",
        );
      }
    } catch (e) {
      if (kDebugMode) {
        log("Error: $e");
      }
    } finally {
      isApiLoading.value = false;
    }
  }

  static Future<void> driverLocationUpdateApi({
    required double latitude,
    required double longitude,
    required String id,
  }) async {
    try {
      bool connection = await NetworkInfo.checkNetwork();
      if (connection) {
        final url =
            Uri.parse(NetWorkUrl.driverLocationUrl).replace(queryParameters: {
          'user_id': id.toString(),
          'latitude': latitude.toString(),
          'longitude': longitude.toString(),
        });
        // Making the PATCH request
        final response = await dio.patch(
          url.toString(),
        );
        log("RESPONSE :- ${response.data}");
        if (response.statusCode == 200) {
          if (response.data['success'] == true) {
            if (kDebugMode) {
              print("Update a Locating");
            }
          }
        } else {
          CustomSnackBar.showSnackBar(
              headerText: AppString.error.tr,
              bodyText: response.data['error']['message'].toString());
        }
      }
    } on DioException catch (e) {
      // Handle DioException
      if (e.response?.statusCode == 404) {
        CustomSnackBar.showSnackBar(
            headerText: AppString.error.tr,
            bodyText: e.response?.data['error'] ?? 'Server Error');
      } else {
        CustomSnackBar.showSnackBar(
            headerText: AppString.error.tr,
            bodyText: "An error occurred. Please try again later.");
      }
    } catch (e) {
      if (kDebugMode) {
        log("Error: $e");
      }
    } finally {}
  }

  static Future<void> getAllDriverApi({
    required double latitude,
    required double longitude,
  }) async {
    try {
      bool connection = await NetworkInfo.checkNetwork();
      if (connection) {
        final body = {
          'pickup_latitude': latitude.toString(),
          'pickup_longitude': longitude.toString(),
        };
        final response = await dio.post(
          NetWorkUrl.getAllDriverUrl,
          data: body,
          options: Options(headers: headers // Add headers if needed
              ),
        );
        if (response.statusCode == 200) {
          final responseData = AllDriversResponse.fromJson(response.data);
          if (responseData.success) {
            // Process the response data
            for (var driver in responseData.drivers) {
              if (kDebugMode) {
                print(
                    'Driver ID: ${driver.userId}, Latitude: ${driver.latitude}, Longitude: ${driver.longitude}, Distance: ${driver.distance}');
              }
              Marker driverMarker = Marker(
                markerId: MarkerId(driver.userId.toString()),
                // Unique identifier for the marker
                position: LatLng(double.parse(driver.latitude),
                    double.parse(driver.longitude)),
                icon: BitmapDescriptor.fromBytes(markerIcons[0]),
                infoWindow:
                    InfoWindow(title: 'Driver ID: ${driver.userId.toString()}'),
              );
              markers.add(driverMarker);
            }
          }
        } else {
          CustomSnackBar.showSnackBar(
            headerText: AppString.error,
            bodyText: response.data['error']['message'].toString(),
          );
        }
      }
    } on DioException catch (e) {
      // Handle DioError
      if (e.response?.statusCode == 404) {
        CustomSnackBar.showSnackBar(
          headerText: AppString.error,
          bodyText: e.response?.data['message'] ?? 'Server Error',
        );
      } else {
        CustomSnackBar.showSnackBar(
          headerText: AppString.error,
          bodyText: "An error occurred. Please try again later.",
        );
      }
    } catch (e) {
      // Handle other errors
      if (kDebugMode) {
        print("Error: $e");
      }
    } finally {
      isApiLoading.value = false;
    }
  }

  static Future<void> bookRideApi({
    required double pickup_lat,
    required double pickup_long,
    required double drop_lat,
    required double drop_long,
    required String pickup_location_main_text,
    required String pickup_location_sub_text,
    required String drop_location_main_text,
    required String drop_location_sub_text,
    required String distance,
    required String price,
    required String mobile,
    required int id,
  }) async {
    try {
      bool connection = await NetworkInfo.checkNetwork();
      if (connection) {
        isApiLoading.value = true;
        final body = {
          "pickup_latitude": pickup_lat,
          "pickup_longitude": pickup_long,
          "dropoff_latitude": drop_long,
          "dropoff_longitude": drop_long,
          "pickup_location_main_text": pickup_location_main_text,
          "pickup_location_sub_text": pickup_location_sub_text,
          "drop_location_main_text": drop_location_main_text,
          "drop_location_sub_text": drop_location_sub_text,
          'distance': distance,
          "price": price,
          "passenger_id": id,
          "passenger_mobile_no": mobile
        };

        final response = await dio.post(
          NetWorkUrl.bookRideUrl,
          data: body,
          options: Options(
            headers: headers, // Add headers if needed
          ),
        );
        log("RESPONSE :- ${response.data}");
        if (response.statusCode == 201) {
          log("RESPONSE :- ${response.data}");
          if (response.data['success'] == true) {
            RideRequest rideRequest = RideRequest.fromJson(response.data);
            for (var driver in rideRequest.rides) {
              await NotificationService.sendPushNotification(
                  token: driver.pushNotification,
                  title: 'Please Check a Ride ${rideRequest.rideId}',
                  body:
                      '$pickup_location_main_text to $drop_location_main_text',
                  data: 'user');
            }
            rideConfirm.value = true;
            sendRideRequestResponseApi(
                id: id.toString(), rideId: rideRequest.rideId.toString());
            CustomSnackBar.showSnackBar(
                headerText: 'Success', bodyText: rideRequest.message);
          }
        } else {
          CustomSnackBar.showSnackBar(
              headerText: AppString.error.tr,
              bodyText: response.data['error']['message'].toString());
        }
      }
    } on DioException catch (e) {
      // Handle DioError
      if (e.response?.statusCode == 400) {
        CustomSnackBar.showSnackBar(
            headerText: AppString.error.tr,
            bodyText: e.response?.data['error'] ?? 'Server Error');
      } else {
        CustomSnackBar.showSnackBar(
            headerText: AppString.error.tr,
            bodyText: "An error occurred. Please try again later.");
      }
    } catch (e) {
      if (kDebugMode) {
        log("Error: $e");
      }
    } finally {
      isApiLoading.value = false;
    }
  }

  static RideRequestList rideRequestList = RideRequestList.fromJson({});
  static RxBool hasData = true.obs;
  static RxBool enterScreen = true.obs;
  static RxBool noData = true.obs;

  static Future<void> getRideRequestApi({
    required String id,
  }) async {
    try {
      bool connection = await NetworkInfo.checkNetwork();
      if (connection) {
        hasData.value = true;
        // Repeat the same process for backPhoto and driverPhoto
        final url =
            Uri.parse(NetWorkUrl.getRideRequestUrl).replace(queryParameters: {
          'driver_id': id,
        });
        // Making the POST request
        final response = await dio.get(url.toString());
        log("RESPONSE :- ${response.data}");
        if (response.statusCode == 200) {
          log("RESPONSE :- ${response.data}");
          if (response.data['success'] == true) {
            rideRequestList = RideRequestList.fromJson(response.data);
            // Notify listeners about the change in rideRequestList
          } else {
            CustomSnackBar.showSnackBar(
                headerText: AppString.error.tr,
                bodyText: response.data['error']['message'].toString());
            noData.value = true; // Set noData to true if there was an error
          }
        }
      }
    } on DioException catch (e) {
      // Handle DioError
      if (e.response?.statusCode == 400) {
        CustomSnackBar.showSnackBar(
            headerText: AppString.error.tr,
            bodyText: e.response?.data['error'] ?? 'Server Error');
      } else {
        CustomSnackBar.showSnackBar(
            headerText: AppString.error.tr,
            bodyText: "An error occurred. Please try again later.");
      }
      noData.value = true; // Set noData to true if there was an error
    } catch (e) {
      if (kDebugMode) {
        log("Error: $e");
      }
      noData.value = true; // Set noData to true if there was an error
    } finally {
      if (rideRequestList.rideRequests.isNotEmpty) {
        noData.value =
            false; // Set noData to false if rideRequestList is not empty
      } else {
        noData.value = true; // Set noData to true if rideRequestList is empty
      }
      hasData.value = false;
    }
  }

  static Future<void> handelRideRequest(
      {required String id,
      required String rideId,
      required String rideInfo,
      required String handelRequest,
      required String pushToken}) async {
    try {
      bool connection = await NetworkInfo.checkNetwork();
      if (connection) {
        isLoading.value = false;
        // Repeat the same process for backPhoto and driverPhoto
        final url = Uri.parse(NetWorkUrl.handelRequestUrl).replace(
            queryParameters: {
              'ride_id': rideId,
              'driver_id': id,
              'status': handelRequest
            });
        // Making the POST request
        final response = await dio.get(url.toString());
        log("RESPONSE :- ${response.data}");
        if (response.statusCode == 200) {
          log("RESPONSE :- ${response.data}");
          if (response.data['success'] == true) {
            CustomSnackBar.showSnackBar(
                headerText: 'Success', bodyText: 'Ride Request Accepted');
            await NotificationService.sendPushNotification(
                token: pushToken,
                title: 'Your Ride is Accept',
                body: rideInfo,
                data: 'Hello How Are y');
            otpCord.value = response.data['ride_request_accepted']['otp'];
            print("===================>${otpCord.value}");
            isLoading.value = true;
          } else {
            CustomSnackBar.showSnackBar(
                headerText: 'Success',
                bodyText: 'Ride Request Rejected Successfully');
            await getRideRequestApi(id: id);
            isLoading.value = false;
          }
        }
      }
    } on DioException catch (e) {
      // Handle DioError
      if (e.response?.statusCode == 400) {
        CustomSnackBar.showSnackBar(
            headerText: AppString.error.tr,
            bodyText: e.response?.data['error'] ?? 'Server Error');
        isLoading.value = false;
        noData.value = true;
      } else {
        CustomSnackBar.showSnackBar(
            headerText: AppString.error.tr,
            bodyText: "An error occurred. Please try again later.");
        noData.value = true;
        isLoading.value = false;
      }
    } catch (e) {
      if (kDebugMode) {
        log("Error: $e");
        noData.value = true;
        isLoading.value = false;
      }
    } finally {}
  }

  static RideRequestResponse? responseData;

  static Future<void> sendRideRequestResponseApi({
    required String id,
    required String rideId,
  }) async {
    try {
      bool connection = await NetworkInfo.checkNetwork();
      if (connection) {
        // Repeat the same process for backPhoto and driverPhoto
        final url = Uri.parse(NetWorkUrl.sendRideRequestUrl).replace(
          queryParameters: {
            'ride_id': rideId,
            'passenger_id': id,
          },
        );
        // Making the POST request
        final response = await dio.get(url.toString());
        log("RESPONSE :- ${response.data}");
        if (response.statusCode == 200) {
          log("RESPONSE :- ${response.data}");
          if (response.data['success'] == 'Waiting') {
            Future.delayed(const Duration(seconds: 10)).then(
                (value) => sendRideRequestResponseApi(id: id, rideId: rideId));
          } else if (response.data['success'] == 'accept') {
            responseData = RideRequestResponse.fromJson(response.data);
            print("================>${responseData!.driverDetails.otp}");
            timeStart.value = true;
            rideStatusPassengerApi(rideId: rideId);
          }
        }
      }
    } on DioException catch (e) {
      // Handle DioError
      if (e.response?.statusCode == 400) {
        CustomSnackBar.showSnackBar(
          headerText: AppString.error.tr,
          bodyText: e.response?.data['error'] ?? 'Server Error',
        );
        noData.value = true;
      } else {
        CustomSnackBar.showSnackBar(
          headerText: AppString.error.tr,
          bodyText: "An error occurred. Please try again later.",
        );
        noData.value = true;
      }
    } catch (e) {
      if (kDebugMode) {
        log("Error: $e");
        noData.value = true;
      }
    } finally {}
  }

  static Future<void> rideStatusPassengerApi({
    required String rideId,
  }) async {
    try {
      isLoading.value = false;
      bool connection = await NetworkInfo.checkNetwork();
      if (connection) {
        // Repeat the same process for backPhoto and driverPhoto
        final url = Uri.parse(NetWorkUrl.rideRequestStatusPassengerUrl)
            .replace(queryParameters: {'ride_id': rideId});
        final response = await dio.get(url.toString());
        if (response.statusCode == 200) {
          if (response.data['success'] == null) {
            Future.delayed(const Duration(seconds: 10)).then(
                (value) async => await rideStatusPassengerApi(rideId: rideId));
          } else if (response.data['success'] == 'true') {
            CustomSnackBar.showSnackBar(
                headerText: 'Success', bodyText: 'Your Ride Started');
            bottomSheet.value = false;
            isLoading.value = true;
            rideArrive.value = true;
          }
        }
      }
    } on DioException catch (e) {
      // Handle DioError
      if (e.response?.statusCode == 400) {
        CustomSnackBar.showSnackBar(
            headerText: AppString.error.tr,
            bodyText: e.response?.data['error'] ?? 'Server Error');
      } else {
        CustomSnackBar.showSnackBar(
            headerText: AppString.error.tr,
            bodyText: "An error occurred. Please try again later.");
      }
    } catch (e) {
      if (kDebugMode) {
        log("Error: $e");
      }
    } finally {}
  }

  static Future<void> verifyOtpDriverApi({
    required String rideId,
  }) async {
    try {
      bool connection = await NetworkInfo.checkNetwork();
      if (connection) {
        isApiLoading.value = true;

        // Repeat the same process for backPhoto and driverPhoto
        final url =
            Uri.parse(NetWorkUrl.otpVerfiRideUrl).replace(queryParameters: {
          'ride_id': rideId,
        });
        // Making the POST request
        final response = await dio.get(url.toString());
        log("RESPONSE :- ${response.data}");
        if (response.statusCode == 200) {
          log("RESPONSE :- ${response.data}");
          if (response.data['success'] == "true") {
            CustomSnackBar.showSnackBar(
                headerText: 'Success',
                bodyText: response.data['message'] ?? "Your Otp Verify");
            bottomSheet.value = false;
            rideArrive.value = true;
          } else {
            CustomSnackBar.showSnackBar(
                headerText: 'error', bodyText: 'Please try again!');
          }
        }
      }
    } on DioException catch (e) {
      // Handle DioError
      if (e.response?.statusCode == 400) {
        CustomSnackBar.showSnackBar(
            headerText: AppString.error.tr,
            bodyText: e.response?.data['error'] ?? 'Server Error');
      } else {
        CustomSnackBar.showSnackBar(
            headerText: AppString.error.tr,
            bodyText: "An error occurred. Please try again later.");
      }
    } catch (e) {
      if (kDebugMode) {
        log("Error: $e");
      }
    } finally {
      isApiLoading.value = false;
    }
  }

  static Future<void> rideComplateApi({
    required String rideId,
  }) async {
    try {
      bool connection = await NetworkInfo.checkNetwork();
      if (connection) {
        isApiLoading.value = true;
        // Repeat the same process for backPhoto and driverPhoto
        final url =
            Uri.parse(NetWorkUrl.rideComplateUrl).replace(queryParameters: {
          'ride_id': rideId,
        });
        // Making the POST request
        final response =
            await dio.post(url.toString(), options: Options(headers: headers));
        log("RESPONSE :- ${response.data}");
        if (response.statusCode == 200) {
          log("RESPONSE :- ${response.data}");
          if (response.data['success'] == true) {
            CustomSnackBar.showSnackBar(
                headerText: 'Success',
                bodyText: response.data['message'] ?? "Ride is Complate");
          } else {
            CustomSnackBar.showSnackBar(
                headerText: 'error', bodyText: 'Please try again!');
          }
        }
      }
    } on DioException catch (e) {
      // Handle DioError
      if (e.response?.statusCode == 400) {
        CustomSnackBar.showSnackBar(
            headerText: AppString.error.tr,
            bodyText: e.response?.data['error'] ?? 'Server Error');
      } else {
        CustomSnackBar.showSnackBar(
            headerText: AppString.error.tr,
            bodyText: "An error occurred. Please try again later.");
      }
    } catch (e) {
      if (kDebugMode) {
        log("Error: $e");
      }
    } finally {
      isApiLoading.value = false;
    }
  }

  static RxList<RideItem> parseRideHistoryList(List<dynamic> list) {
    return RxList<RideItem>(
      list.map((item) => RideItem.fromJson(item)).toList(),
    );
  }

  static RxList<RideHistoryItemPass> parseDriverRideHistoryList(List<dynamic> list) {
    return RxList<RideHistoryItemPass>.from(
      list.map((item) => RideHistoryItemPass.fromJson(item)).where(
            (item) => item.driverId.isNotEmpty,
      ),
    );
  }

  static Future<RxList<dynamic>?> rideHistoryApi() async {
    try {
      bool connection = await NetworkInfo.checkNetwork();
      if (connection) {
        isLoading.value = true;
        var id;
        bool isPassenger =
            await Constant.instance.dbHelper.driver.get(HiveKeys.isPassenger) ??
                false;
        if (isPassenger) {
          id =
              await Constant.instance.dbHelper.passenger.get(HiveKeys.id) ?? '';
        } else {
          id = await Constant.instance.dbHelper.driver.get(HiveKeys.id) ?? '';
        }
        final url = Uri.parse(isPassenger
            ? NetWorkUrl.rideHistoryPassangerUrl
            : NetWorkUrl.rideHistoryUrl);
        final response = await dio.get(url.toString(), queryParameters: {
          !isPassenger ? 'passenger_id' : 'driver_id': 1.toString(),
        });
        log("RESPONSE :- ${response.data}");

        if (response.statusCode == 200) {
          final success = response.data['success'];
          if (success == true) {
            return isPassenger
                ? parseRideHistoryList(response.data['ride_history'])
                : parseDriverRideHistoryList(response.data['ride_history']);

          } else {
            return null;
          }
        }
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
      } else {}
    } catch (e) {
      if (kDebugMode) {
        log("Error: $e");
      }
    } finally {
      isLoading.value = false;
    }
    return null;
  }

  static Future<void> addPaymentApi({
    required String transectionId,
    required String amount,
  }) async {
    try {
      bool connection = await NetworkInfo.checkNetwork();
      if (connection) {
        var id;
        bool isPassanger =
            await Constant.instance.dbHelper.driver.get(HiveKeys.isPassenger) ??
                false;
        if (isPassanger) {
          id =
              await Constant.instance.dbHelper.passenger.get(HiveKeys.id) ?? '';
        } else {
          id = await Constant.instance.dbHelper.driver.get(HiveKeys.id) ?? '';
        }
        isApiLoading.value = true;
        var now = DateTime.now();
        var date = "${now.day}-${now.month}-${now.year}";
        var time = "${now.hour}-${now.minute}-${now.second}";
        final body = {
          isPassanger ? 'passenger_id' : 'driver_id': id.toString(),
          "transaction_id": transectionId,
          "date": date,
          "time": time,
          "amount": amount,
          "payment_status": "success"
        };
        // Making the POST request
        final response = await dio.post(
          NetWorkUrl.addAmountUrl,
          data: body,
          options: Options(headers: headers),
        );
        log("RESPONSE :- ${response.data}");
        if (response.statusCode == 200) {
          log("RESPONSE :- ${response.data}");
          if (response.data['success'] == true) {
            CustomSnackBar.showSnackBar(
                headerText: 'Success',
                bodyText:
                    response.data['message'] ?? "Your Payment Successfully");
            isApiLoading.value = false;
            showAmountApi();
          } else {
            CustomSnackBar.showSnackBar(
                headerText: 'error', bodyText: 'Please try again!');
            isApiLoading.value = false;
          }
        }
      }
    } on DioException catch (e) {
      // Handle DioError
      if (e.response?.statusCode == 500) {
        CustomSnackBar.showSnackBar(
            headerText: AppString.error.tr,
            bodyText: e.response?.data['error'] ?? 'Server Error');
      } else {
        CustomSnackBar.showSnackBar(
            headerText: AppString.error.tr,
            bodyText: "An error occurred. Please try again later.");
      }
    } catch (e) {
      if (kDebugMode) {
        log("Error: $e");
      }
    } finally {
      isApiLoading.value = false;
    }
  }

  static Future<void> showAmountApi() async {
    try {
      bool connection = await NetworkInfo.checkNetwork();
      if (connection) {
        amount.value = '00';
        var id;
        bool isPassanger =
            await Constant.instance.dbHelper.driver.get(HiveKeys.isPassenger) ??
                false;
        if (isPassanger) {
          id =
              await Constant.instance.dbHelper.passenger.get(HiveKeys.id) ?? '';
        } else {
          id = await Constant.instance.dbHelper.driver.get(HiveKeys.id) ?? '';
        }
        // Making the POST request
        final url = Uri.parse(NetWorkUrl.showAmountUrl).replace(
          queryParameters: {
            isPassanger ? 'passenger_id' : 'driver_id': id.toString(),
          },
        );
        final response = await dio.get(url.toString());
        log("RESPONSE :- ${response.data}");
        if (response.statusCode == 200) {
          log("RESPONSE :- ${response.data}");
          if (response.data['success'] == true) {
            amount.value = response.data['amount'];
          } else {
            CustomSnackBar.showSnackBar(
                headerText: 'error', bodyText: 'Please try again!');
          }
        }
      }
    } on DioException catch (e) {
      // Handle DioError
      if (e.response?.statusCode == 500) {
      } else {}
    } catch (e) {
      if (kDebugMode) {
        log("Error: $e");
      }
    } finally {}
  }

  static Future<void> addBankDetails(
      {required String bankAccNum,
      required String ifscCode,
      required String bankHolderName,
      required File image}) async {
    try {
      bool connection = await NetworkInfo.checkNetwork();
      if (connection) {
        // Prepare form data
        dios.FormData formData = dios.FormData.fromMap({
          "driver_id":
              await Constant.instance.dbHelper.driver.get(HiveKeys.id) ?? '',
          "bank_acc_number": bankAccNum,
          "ifsc_code": ifscCode,
          "bank_acc_holder_name": bankHolderName,
          "qr_code": await dios.MultipartFile.fromFile(image.path,
              filename: "qr_code.jpg"),
        });

        // Making the POST request
        final response = await dio.post(
          NetWorkUrl.bankDetailsUrl,
          data: formData,
          options: Options(headers: headers),
        );

        // Process the response
        log("RESPONSE :- ${response.data}");
        CustomSnackBar.showSnackBar(
            headerText: 'Success', bodyText: response.data['message']);
        if (response.statusCode == 200) {
          CustomSnackBar.showSnackBar(
              headerText: 'Success', bodyText: response.data['message']);
          log("RESPONSE :- ${response.data}");
          if (response.data['success'] == true) {
          } else {
            CustomSnackBar.showSnackBar(
              headerText: 'error',
              bodyText: 'Please try again!',
            );
          }
        }
      }
    } on DioError catch (e) {
      // Handle DioError
      if (e.response?.statusCode == 500) {
        // Handle specific status code
      } else {
        // Handle other Dio errors
      }
    } catch (e) {
      // Handle other exceptions
      if (kDebugMode) {
        log("Error: $e");
      }
    }
  }

  static Future<void> lockAmountApi() async {
    try {
      bool connection = await NetworkInfo.checkNetwork();
      if (connection) {
        lockAmount.value = '00';
        // Prepare form data
        var id = await Constant.instance.dbHelper.driver.get(HiveKeys.id) ?? '';
        final url = Uri.parse(NetWorkUrl.lockAmountUrl).replace(
          queryParameters: {
            'driver_id': id.toString(),
          },
        );
        final response = await dio.get(url.toString());
        // Process the response
        log("RESPONSE :- ${response.data}");
        if (response.statusCode == 200) {
          log("RESPONSE :- ${response.data}");
          if (response.data['success'] == true) {
            lockAmount.value = response.data['lock amount'].toString();
          } else {
            CustomSnackBar.showSnackBar(
              headerText: 'error',
              bodyText: 'Please try again!',
            );
          }
        }
      }
    } on DioError catch (e) {
      // Handle DioError
      if (e.response?.statusCode == 500) {
        // Handle specific status code
      } else {
        // Handle other Dio errors
      }
    } catch (e) {
      // Handle other exceptions
      if (kDebugMode) {
        log("Error: $e");
      }
    }
  }

  static Future<void> redeemAmountApi() async {
    try {
      bool connection = await NetworkInfo.checkNetwork();
      if (connection) {
        // Prepare form data
        isApiLoading.value = true;
        var id = await Constant.instance.dbHelper.driver.get(HiveKeys.id) ?? '';
        final response = await dio.post(NetWorkUrl.redeemAmountUrl,
            data: {
              'driver_id': id.toString(),
            },
            options: Options(headers: headers));
        // Process the response
        log("RESPONSE :- ${response.data}");
        if (response.statusCode == 200) {
          CustomSnackBar.showSnackBar(
            headerText: AppString.success.tr,
            bodyText: response.data['message'] ??
                'Redeemed amount to wallet successfully',
          );
          log("RESPONSE :- ${response.data}");
          if (response.data['success'] == true) {
          } else {
            CustomSnackBar.showSnackBar(
              headerText: 'error',
              bodyText: 'Please try again!',
            );
          }
        }
      }
    } on DioError catch (e) {
      // Handle DioError
      if (e.response?.statusCode == 500) {
        // Handle specific status code
      } else {
        // Handle other Dio errors
      }
    } catch (e) {
      // Handle other exceptions
      if (kDebugMode) {
        log("Error: $e");
      }
    } finally {
      isApiLoading.value = false;
    }
  }
  static Future<void> toggeleApi() async {
    try {
      bool connection = await NetworkInfo.checkNetwork();
      if (connection) {
        // Prepare form data
        isApiLoading.value = true;
        var id = await Constant.instance.dbHelper.driver.get(HiveKeys.id) ?? '';
        final response = await dio.post(NetWorkUrl.toggleAmountUrl,
            data: {
              'driver_id': id.toString(),
            },
            options: Options(headers: headers));
        // Process the response
        log("RESPONSE :- ${response.data}");
        if (response.statusCode == 200) {
          CustomSnackBar.showSnackBar(
            headerText: AppString.success.tr,
            bodyText: response.data['message'] ??
                'Driver is now unavailable',
          );
          log("RESPONSE :- ${response.data}");
          if (response.data['success'] == true) {
            CustomSnackBar.showSnackBar(
              headerText: AppString.success.tr,
              bodyText: response.data['message'] ??
                  'Driver is now unavailable',
            );
          } else {
            CustomSnackBar.showSnackBar(
              headerText: 'error',
              bodyText: 'Please try again!',
            );
          }
        }
      }
    } on DioError catch (e) {
      // Handle DioError
      if (e.response?.statusCode == 500) {
        // Handle specific status code
      } else {
        // Handle other Dio errors
      }
    } catch (e) {
      // Handle other exceptions
      if (kDebugMode) {
        log("Error: $e");
      }
    } finally {
      isApiLoading.value = false;
    }
  }
 static RxBool noTransation=false.obs;
  static RxList<Transaction> transactionList = <Transaction>[].obs;

  static Future<void> showTransactionApi() async {
    try {
      bool connection = await NetworkInfo.checkNetwork();
      if (connection) {
        isApiLoading.value = true;
        noTransation.value=false;
        var id;
        bool isPassenger =
            await Constant.instance.dbHelper.driver.get(HiveKeys.isPassenger) ??
                false;
        if (isPassenger) {
          id =
              await Constant.instance.dbHelper.passenger.get(HiveKeys.id) ?? '';
        } else {
          id = await Constant.instance.dbHelper.driver.get(HiveKeys.id) ?? '';
        }

        final url = Uri.parse(NetWorkUrl.transationsHistoryUrl).replace(
          queryParameters: {
            isPassenger ? 'passenger_id' : 'driver_id': id.toString(),
          },
        );

        final response = await dio.get(url.toString());
        log("RESPONSE :- ${response.data}");
        if (response.statusCode == 200) {
          transactionList.clear();
          transactionList.value =
              (response.data['Transactions'] as List)
                  .map((item) => Transaction.fromJson(item))
                  .toList();
        } else {
          CustomSnackBar.showSnackBar(
            headerText: 'error',
            bodyText: 'Please try again!',
          );
        }
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        noTransation.value=true;
        // Handle specific status code
      } else {
        // Handle other Dio errors
      }
    } catch (e) {
      if (kDebugMode) {
        log("Error: $e");
      }
    } finally {
      isApiLoading.value = false;
    }
  }
  static Future<void> sendAmountApi({required String reciverPhone,required amount}) async {
    try {
      bool connection = await NetworkInfo.checkNetwork();
      if (connection) {
        isApiLoading.value = true;
        var phone;
        bool isPassenger =
            await Constant.instance.dbHelper.driver.get(HiveKeys.isPassenger) ??
                false;
        if (isPassenger) {
          phone =
              await Constant.instance.dbHelper.passenger.get(HiveKeys.mobileNumber) ?? '';
        } else {
          phone = await Constant.instance.dbHelper.driver.get(HiveKeys.mobileNumber) ?? '';
        }


        final response = await dio.post(NetWorkUrl.sendAmountUrl,
            data: {
              'sender_mobile_number': phone,
              'receiver_mobile_number':reciverPhone,
              'user_type':isPassenger?'passenger':'driver',
              'amount':amount
            },
            options: Options(headers: headers));
        log("RESPONSE :- ${response.data}");
        if (response.statusCode == 200) {
          CustomSnackBar.showSnackBar(
            headerText: AppString.success.tr,
            bodyText: response.data['message']??'Money sent successfully',
          );
        } else {
          CustomSnackBar.showSnackBar(
            headerText: 'error',
            bodyText: 'Please try again!',
          );
        }
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        CustomSnackBar.showSnackBar(
          headerText: 'error',
          bodyText: 'Receiver not found',
        );
        // Handle specific status code
      } else {
        // Handle other Dio errors
      }
    } catch (e) {
      if (kDebugMode) {
        log("Error: $e");
      }
    } finally {
      isApiLoading.value = false;
    }
  }
  static Future<void> forgetPinApi({required String phone,required String password,required bool isPassenger}) async {
    try {
      bool connection = await NetworkInfo.checkNetwork();
      if (connection) {
        isApiLoading.value = true;

        final response = await dio.post(NetWorkUrl.forgatePinUrl,
            data: {
              'mobile_number': phone,
              'user_type':isPassenger?'passenger':'driver',
              'password':password
            },
            options: Options(headers: headers));
        log("RESPONSE :- ${response.data}");
        if (response.data['success'] == true) {
          CustomSnackBar.showSnackBar(
            headerText: AppString.success.tr,
            bodyText: response.data['message']??'password change successfully',
          );
        } else {
          CustomSnackBar.showSnackBar(
            headerText: 'error',
            bodyText: 'Mobile number not found',
          );
        }
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        CustomSnackBar.showSnackBar(
          headerText: 'error',
          bodyText: 'Receiver not found',
        );
        // Handle specific status code
      } else {
        // Handle other Dio errors
      }
    } catch (e) {
      if (kDebugMode) {
        log("Error: $e");
      }
    } finally {
      isApiLoading.value = false;
    }
  }
}
