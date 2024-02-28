import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';


class PushNotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  final _androidChannel = const AndroidNotificationChannel(
      'high_importance_channel', 'High Importance Notification',
      description: 'This is used for importance notification',
      importance: Importance.defaultImportance);

  static final _localNotification = FlutterLocalNotificationsPlugin();

  // Future<void> handleBackroundMessage(RemoteMessage message) async {
  //   if (message.notification != null) {
  //     print('Title: ${message.notification?.title ?? ''}');
  //     print('Body: ${message.notification?.body ?? ''}');
  //     print('Pauload: ${message.data}');
  //   }
  // }
  Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  

    print('Handling a background message ${message.messageId}');
  }

  Future<String> getDeviceToken() async {
    try {
      if (Platform.isAndroid) {
        var status = await Permission.notification.request();
        await _firebaseMessaging.requestPermission(
            alert: true, badge: true, sound: true);
      }
      String? deviceToken = await _firebaseMessaging.getToken();

      print('Device Token: $deviceToken');
     
        initPushNotification();
        initLocalNotification();



      return deviceToken!;
    } catch (e) {
      print('Error getting device token: $e');
      return e.toString();
    }
  }

 

  Future<void> requestNotificationPermission() async {
    
   
  }

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;
    // EditProfileScreen().navigate();
  }

  Future<void> initPushNotification() async {
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await _localNotification.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (payload) =>
          onSelectNotification(payload.payload),
    );

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final notification = message.notification;
      if (notification == null) return;
      showNotification(
        notification.title.toString(),
        notification.body.toString(),
        jsonEncode(message.toMap()),
      );
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      handleForegroundMessage(message);
    });

    // FirebaseMessaging.onBackgroundMessage((message)async{
    //  await firebaseMessagingBackgroundHandler(message);
    // });
  }

  // static Future<Uint8List> _getByteArrayFromUrl(String url) async {
  //   print(url);
  //   final http.Response response = await http.get(Uri.parse(url));
  //   return response.bodyBytes;
  // }

  static Future<void> showNotification(
      String title, String body, String payload) async {
    // final ByteArrayAndroidBitmap bigPicture =
    //     ByteArrayAndroidBitmap(await _getByteArrayFromUrl(image));
    await _localNotification.show(
      0,
      title,
      body,
      NotificationDetails(
        android: AndroidNotificationDetails(
            'high_importance_channel', 'high_importance_channel',
            channelDescription: 'your_channel_description',
            importance: Importance.max,
            priority: Priority.high,
            color: Colors.blue,
            styleInformation: BigTextStyleInformation(title,
                contentTitle: body,
                htmlFormatSummaryText: true,
                htmlFormatContentTitle: true)),
      ),
      payload: payload,
    );
  }

  Future<void> handleBackgroundMessage(RemoteMessage message) async {
    final notification = message.notification;
    if (notification == null) return;

    showNotification(
      notification.title.toString(),
      notification.body.toString(),
      jsonEncode(message.toMap()),
    );
  }

  Future<void> handleForegroundMessage(RemoteMessage message) async {
    final notification = message.notification;
    if (notification == null) return;

    showNotification(
      notification.title.toString(),
      notification.body.toString(),
      jsonEncode(message.toMap()),
    );
  }

  Future<void> onSelectNotification(String? payload) async {
    if (payload != null) {
      print('Notification payload: $payload');
      // Handle payload as needed
    }
  }

  Future initLocalNotification() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const setting = InitializationSettings(android: android);

    await _localNotification.initialize(
      setting,
      onDidReceiveNotificationResponse: (details) {
        final message =
            RemoteMessage.fromMap(jsonDecode(details.payload.toString()));
        handleMessage(message);
      },
    );
    final platform = _localNotification.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidChannel);
  }
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message');
  print(message.notification);
  if (message.data.isNotEmpty) {
    print('title: ${message.data['text'].toString()}');
    print('title: ${message.data['text'].toString()}');
    print('title: ${message.data['image'].toString()}');
    print("yeee");
    PushNotificationService.showNotification(message.data['text'].toString(),
        message.data['text'].toString(), '');
  } else {
    print('no msg');
  }
}
