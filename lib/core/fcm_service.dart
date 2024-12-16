import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessagingService {
  static final FirebaseMessagingService _instance =
      FirebaseMessagingService._internal();

  factory FirebaseMessagingService() {
    return _instance;
  }

  FirebaseMessagingService._internal();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initMessaging() async {
    // For iOS request permission first.
    final fcmPermission = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );
    print('User granted permission: ${fcmPermission.authorizationStatus}');

    if (Platform.isIOS) {
      final apnsToken = await FirebaseMessaging.instance.getAPNSToken();
      if (apnsToken == null) {
        return;
      }
    }
    _firebaseMessaging.getInitialMessage();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      //TODO: handle notification using flutter_local_notifications

      if (message.notification != null) {
        print(
            "The notification message is ${message.notification?.body} ==== ${message.notification?.android?.channelId} ==== ${message.notification?.title} ==== ${message.senderId} ==== ${message.category} ==== ${message.notification?.android?.channelId} ==== ${message.messageType} ==== ${message.data} ==== ${message.notification} ");
        BotToast.showText(
            text: "Message Received ==== ${message.notification?.body}");
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      //TODO: handle notification using flutter_local_notifications
      print(
          "The on opened   message is ${message.notification?.body} ==== ${message.notification?.android?.channelId} ==== ${message.notification?.title} ==== ${message.senderId} ==== ${message.category} ==== ${message.notification?.android?.channelId} ==== ${message.messageType} ==== ${message.data} ==== ${message.notification} ");
      BotToast.showText(
          text: "Message Received ==== ${message.notification?.body}");
    });

    onTokenRefresh();
  }

  onTokenRefresh() {
    _firebaseMessaging.onTokenRefresh.listen((fcmToken) {
      // Note: This callback is fired at each app startup and whenever a new
      // token is generated.
      // locator<ProfileBloc>().refreshFcmToken(fcmToken);
    }).onError((err) {
      // Error getting token.
    });
  }

  // sendToken() async {
  //   String? fcmToken = await getToken();
  //   if (fcmToken != null) locator<ProfileBloc>().refreshFcmToken(fcmToken);
  // }

  // Other methods related to FirebaseMessaging can be added here.

  // For example, you can add a method to get the token:
  Future<String?> getToken() async {
    print("Firebase fcm token ==== ${await _firebaseMessaging.getToken()}");
    return await _firebaseMessaging.getToken();
  }

  deleteToken() {
    _firebaseMessaging.deleteToken();
  }
}




/* class Wapper {
  void handleClickNotification() {
    shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      var data = result.notification.additionalData;
      if (data != null) {
        String? _url = data["url"];
        DeepLinkManager(_url)
            .openPage(RouteConfig.navigatorKey.currentState!.context);
      } else if (result.notification.launchUrl != null) {
        final String launchUrl = result.notification.launchUrl!
            .replaceAll("notification:/", "https://www.ugcakes.com");
        DeepLinkManager(launchUrl)
            .openPage(RouteConfig.navigatorKey.currentState!.context);
      }
    });
  }
}
 */