import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart'as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../app_export.dart';

class NotificationService {

  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;

  static Future<void> _iOSPermission() async {
    await _firebaseMessaging.requestPermission(
      sound: true,
      badge: true,
      alert: true,
    );
    _firebaseMessaging.getNotificationSettings();
  }
  static Map<String, dynamic> result = <String, dynamic>{};
  static void _handleMessage(RemoteMessage message) {
    final String daata = message.data.toString();
    final List<String> str = daata.replaceAll('{', '').replaceAll('}', '').split(',');

    for (int i = 0; i < str.length; i++) {
      final List<String> s = str[i].split(':');
      result.putIfAbsent(s[0].trim(), () => s[1].trim());
    }
    if(result["data"]=="admin"){
      Get.toNamed(AppRoutes.homeScreenRoutes);
    }else{
      Get.toNamed(AppRoutes.homeScreenRoutes);
    }
    if (result["type"] != null) {
      // Handle your message type if needed
    }
  }

  static void _onMessageListener(RemoteMessage message) {
    try {
      showNotification(message);
    } catch (e) {
      if (kDebugMode) {
        print('Error in _onMessageListener: $e');
      }
    }
  }
  static Future<void> backgroundMessageHandler(RemoteMessage message) async {
    showNotification(message);
    final String daata = message.data.toString();
    final List<String> str = daata.replaceAll('{', '').replaceAll('}', '').split(',');

    for (int i = 0; i < str.length; i++) {
      final List<String> s = str[i].split(':');
      result.putIfAbsent(s[0].trim(), () => s[1].trim());
    }
    if (kDebugMode) {
      print(result);
    }
  }



  static Future<void> firebaseCloudMessagingListener() async {
    if (Platform.isIOS) {
      _iOSPermission();
    }

    RemoteMessage? initialMessage = await FirebaseMessaging.instance
        .getInitialMessage();

    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    FirebaseMessaging.onMessage.listen(_onMessageListener);

    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);

    FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler);

    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
  static Future<void> sendPushNotification({required String token,required String title,required String body,required String data}) async {
    try {
      const serverKey = "AAAAvLDjJTw:APA91bF_n2WjHSJTSMQ44hjayJi5zRnfFGO72O01I6XuCgDO5b7SCHPLcNpqRm1_Fmd-z3L6Kq1SHLLb7f-7bl4BSb1wnb6OMpXHx4L-i1PIkOVTGPNR5uHXgAdlQh07CbJsbmNIHTjK";
      final url = Uri.parse('https://fcm.googleapis.com/fcm/send');

      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverKey',
      };

      final payload = {
        'to': token,
        'notification': {
          'title': title,
          'body': body,
        },
        "data":{
          "data": data
        }
      };

      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(payload),
      );
      if (kDebugMode) {
        print("FCM Response: ${response.body}");
      }

    } catch (e) {
      log('sendPushNotificationE: $e');
    }
  }

  static final flutterLocalNotifications = FlutterLocalNotificationsPlugin();


  static Future<void> initialize() async {

    const AndroidInitializationSettings androidSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings();
    const InitializationSettings initializationSettings =
    InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await flutterLocalNotifications.initialize(initializationSettings,
        onDidReceiveBackgroundNotificationResponse: _onSelectNotification,
        onDidReceiveNotificationResponse: _onSelectFrontNotification);
    if (Platform.isIOS) {
      await flutterLocalNotifications
          .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
    } else {
      await flutterLocalNotifications
          .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();
    }
  }

  static _onSelectNotification(NotificationResponse? payload) async {
    if (payload != null) {
      final List<String> str =
      payload.payload!.replaceAll('{', '').replaceAll('}', '').split(',');
      final Map<String, dynamic> result = <String, dynamic>{};
      for (int i = 0; i < str.length; i++) {
        final List<String> s = str[i].split(':');
        result.putIfAbsent(s[0].trim(), () => s[1].trim());
        if (kDebugMode) {
          print(result);
        }
      }
      if(result["data"]=="admin"){
        Get.toNamed(AppRoutes.homeScreenRoutes);
      }else{
        Get.toNamed(AppRoutes.homeScreenRoutes);
      }
      if (result["type"] != null) {
        // DeepLinking.GoTo(
        //     int.parse(result["type"]),
        //     int.parse(result["redirect_on"]),
        //     int.parse(result["redirect_on"]),
        //     context);
      }
    }
  }

  static _onSelectFrontNotification(NotificationResponse? payload) async {
    if (payload != null) {
      final List<String> str =
      payload.payload!.replaceAll('{', '').replaceAll('}', '').split(',');
      final Map<String, dynamic> result = <String, dynamic>{};
      for (int i = 0; i < str.length; i++) {
        final List<String> s = str[i].split(':');
        result.putIfAbsent(s[0].trim(), () => s[1].trim());
      }
      if (kDebugMode) {
        print(result);
      }
      if(result["data"]=="admin"){
        Get.toNamed(AppRoutes.homeScreenRoutes);
      }else{
        Get.toNamed(AppRoutes.homeScreenRoutes);
      }
      if (result["type"] != null) {
        // DeepLinking.GoTo(
        //     int.parse(result["type"]),
        //     int.parse(result["redirect_on"]),
        //     int.parse(result["redirect_on"]),
        //     context);
      }
    }
  }

  static Future<void> showNotification(RemoteMessage message) async {


    const AndroidNotificationDetails androidPlatformChannel =
    AndroidNotificationDetails(
      'high_importance_channel', 'High Importance Notifications',
      channelShowBadge: false,
      importance: Importance.max,
      priority: Priority.max,
      playSound: true,
      icon: "@mipmap/ic_launcher",
      autoCancel: true,
      // onlyAlertOnce: true,
    );

    const NotificationDetails platformChannel = NotificationDetails(
      android: androidPlatformChannel,
    );

    await flutterLocalNotifications.show(
      message.ttl ?? 0,
      message.notification?.title??"hello",
      message.notification?.body??"how are you",
      platformChannel,
      payload: message.data.toString(),
    );


  }


  clearAllNotification() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}
