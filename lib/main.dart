import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:localgovernment_project/utils/push_notifications_service.dart';
import 'package:localgovernment_project/views/auth/splash_screen/splash_screen.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    final client = super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;

    return client;
  }
}

Future<void> firebaseMessaging() async {
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  // Request permission for iOS
  await firebaseMessaging.requestPermission();

  // Foreground messages
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {});

  // Background handler
  FirebaseMessaging.onBackgroundMessage(
      _firebaseMessagingBackgroundHandler);
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}


Future<void> main() async {
  
  WidgetsFlutterBinding.ensureInitialized();

   WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  // Request permission (important for iOS)
  await FirebaseMessaging.instance.requestPermission();

  await firebaseMessaging();

  if (kDebugMode && Platform.isIOS) {
    await FirebaseAuth.instance.setSettings(
      appVerificationDisabledForTesting: true,
    );
  }

  // await FirebaseAppCheck.instance.activate();

  await FlutterDownloader.initialize(debug: true);

  await dotenv.load(fileName: ".env");

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    Phoenix(
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          localizationsDelegates: const [],

          supportedLocales: const [
            Locale('en'),
            Locale('ur'),
          ],

          builder: (BuildContext context, Widget? child) {
            final MediaQueryData data = MediaQuery.of(context).copyWith(
              textScaler: const TextScaler.linear(1.0),
            );

            return MediaQuery(
              data: data,
              child: child!,
            );
          },

          debugShowCheckedModeBanner: false,

          theme: ThemeData(
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white,
            ),
            scaffoldBackgroundColor: Colors.grey,
            canvasColor: Colors.transparent,
            snackBarTheme: const SnackBarThemeData(
              backgroundColor: Colors.white54,
            ),
          ),

          home: const SplashScreen(),

          onInit: () {
            PushNotificationService().setupInteractedMessage();
          },
        );
      },
    );
  }
}