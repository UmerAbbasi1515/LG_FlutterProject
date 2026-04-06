// ignore_for_file: unused_import

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localgovernment_project/data/helpers/session_controller.dart';
import 'package:localgovernment_project/utils/constants/assets_path.dart';
import 'package:localgovernment_project/views/auth/splash_screen/splash_screen_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  final splashScreenController = Get.put(SplashScreenController());

  // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  @override
  void initState() {
    // _getFcmToken();
    _setupNotificationListeners();
    super.initState();
  }

  // void _getFcmToken() async {
  //   if (defaultTargetPlatform == TargetPlatform.iOS) {
  //     if (kDebugMode == false) {
  //       String? token = await _firebaseMessaging.getAPNSToken();
  //       if (kDebugMode) {
  //         print('FCM Token: $token');
  //       }
  //     } else {
  //       String? token = await _firebaseMessaging.getToken();
  //       if (kDebugMode) {
  //         print('FCM Token: $token');
  //       }
  //     }
  //   }else{
  //     FirebaseMessaging.instance.getToken().then((String? token) {
  //     if (kDebugMode) {
  //       print("FCM Token: $token");
  //     }
  //   });
  //   }
  // }
  


  void _setupNotificationListeners() {
    // Handle incoming messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (kDebugMode) {
        print('Message received: ${message.messageId}');
      }
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Handle notifications when the app is opened from a terminated state
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (kDebugMode) {
        print('Message clicked: ${message.messageId}');
      }
    });
  }

  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    if (kDebugMode) {
      print('Handling a background message: ${message.messageId}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF001838),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImagesPath.splashMainImage),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
