import 'dart:developer';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<String> getDeviceToken() async {
    final preference = await SharedPreferences.getInstance();
    String? token = await messaging.getToken();
    log("fcm on notification service tok :$token ");
    if (token != null) {
      preference.setString('fcmToken', token.toString());
      return token;
    } else {
      throw Exception("Failed to get FCM token");
    }
  }

  void isRefreshToken() async {
    messaging.onTokenRefresh.listen((token) async {
      token.toString();
      log('TOken Refereshed: $token');
      final preference = await SharedPreferences.getInstance();
      await preference.setString('fcmToken', token);
    });
  }

  void requestNotificationPermisions() async {
    if (Platform.isIOS) {
      await messaging.requestPermission(
          alert: true,
          announcement: true,
          badge: true,
          carPlay: true,
          criticalAlert: true,
          provisional: true,
          sound: true);
    }

    NotificationSettings notificationSettings =
        await messaging.requestPermission(
            alert: true,
            announcement: true,
            badge: true,
            carPlay: true,
            criticalAlert: true,
            provisional: true,
            sound: true);

    if (notificationSettings.authorizationStatus ==
        AuthorizationStatus.authorized) {
      log('user is already granted permisions');
      log("notification not ==========");
    } else if (notificationSettings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      log('user is already granted provisional permisions');
    } else {
      log('User has denied permission');
    }
  }

  // For IoS
  Future forgroundMessage() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);
  }

  void firebaseInit(BuildContext context) {
    FirebaseMessaging.onMessage.listen((message) {
      debugPrint('Got a message whilst in the foreground!');
      debugPrint('Message data: ${message.notification!.title.toString()}');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification!.android;

      log("Notification title: ${notification!.title}");
      log("Notification title: ${notification.body}");
      log("Data: ${message.data.toString()}");

      // For IoS
      if (Platform.isIOS) {
        forgroundMessage();
      }

      if (Platform.isAndroid) {
        initLocalNotifications(context, message);
        showNotification(message);
      }
    });
  }

  void initLocalNotifications(
      BuildContext context, RemoteMessage message) async {
    var androidInitSettings =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitSettings = const DarwinInitializationSettings();

    var initSettings = InitializationSettings(
        android: androidInitSettings, iOS: iosInitSettings);

    await _flutterLocalNotificationsPlugin.initialize(initSettings,
        onDidReceiveNotificationResponse: (payload) {
      handleMesssage(context, message);
    });
  }

  // void handleMesssage(BuildContext context, RemoteMessage message) {
  //   log('In handleMesssage function');
  //   if (message.data['type'] == 'text') {
  //     log(message.data.toString());

  //     // redirect to new screen or take different action based on payload that you receive.
  //   }
  // }

  void handleMesssage(BuildContext context, RemoteMessage message) {
    log('In handleMesssage function');
    String? messageType = message.data['type'];

    if (messageType != null) {
      log('Message type: $messageType');
      log('Message data: ${message.data}');
      Widget screen;
      switch (messageType) {
        case 'text':
          // screen = SavedDoctorsScreen();
          // navigatorKey.currentState?.push(
          //     MaterialPageRoute(builder: (context) => SavedDoctorsScreen()));
          log("screen 0");
          break;
        case 'chat':
          // navigatorKey.currentState?.push(
          //     MaterialPageRoute(builder: (context) => SavedDoctorsScreen()));
          log("screen 1"); // Replace with the actual screen for chat
          break;
        default:
          log('Unknown message type: $messageType');
          return;
      }
    }

    // if (message.data['type'] == 'text') {

    //   log(message.data.toString());
    //    log("log text done ===============");

    //   // Navigate to the profile screen
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(builder: (context) => SavedDoctorsScreen()),
    //   );
    // }
//  else  if (message.data['type']=='chat') {
//     log("log chat done =====================");
//     log(message.data.toString());
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => SavedDoctorsScreen()),
//     );
//   }
    //log("un   log");
  }

  Future<void> showNotification(RemoteMessage message) async {
    if (message.notification?.android == null) return;
    AndroidNotificationChannel androidNotificationChannel =
        AndroidNotificationChannel(
      message.notification!.android!.channelId.toString(),
      message.notification!.android!.channelId.toString(),
      importance: Importance.max,
      showBadge: true,
      playSound: true,
    );

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(androidNotificationChannel.id.toString(),
            androidNotificationChannel.name.toString(),
            channelDescription: 'Flutter Notifications',
            importance: Importance.max,
            priority: Priority.high,
            playSound: true,
            ticker: 'ticker',
            sound: androidNotificationChannel.sound);

    const DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails(
            presentAlert: true, presentBadge: true, presentSound: true);

    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);

    Future.delayed(Duration.zero, () {
      _flutterLocalNotificationsPlugin.show(
          0,
          message.notification!.title.toString(),
          message.notification!.body.toString(),
          notificationDetails);
    });
  }

  Future<void> setupInteractMessage(BuildContext context) async {
    // when app is terminated
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      handleMesssage(context, initialMessage);
    }

    //when app ins background
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      handleMesssage(context, event);
    });
  }
}
