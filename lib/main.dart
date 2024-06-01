import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_doctor/Ui/Consts/app_theme_style.dart';
import 'package:mediezy_doctor/Ui/Consts/bloc_providers.dart';
import 'package:mediezy_doctor/Ui/Screens/AuthenticationsScreens/SplashScreen/splash_screen.dart';
import 'package:mediezy_doctor/firebase_options.dart';
import 'package:upgrader/upgrader.dart';

import 'Repositary/Api/firebase_service/notification_service.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  log("its not working ");
  await Firebase.initializeApp();
  log("its not working ");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  runApp(
    MultiBlocProvider(
      providers: AppBBlocProviders.allBlocProviders,
      child: const MediezyDoctor(),
    ),
  );
}

class MediezyDoctor extends StatefulWidget {
  const MediezyDoctor({super.key});

  @override
  State<MediezyDoctor> createState() => _MediezyDoctorState();
}

class _MediezyDoctorState extends State<MediezyDoctor> {
  late StreamSubscription<ConnectivityResult> subscription;
  bool hasInternet = false;
  NotificationServices notificationServices = NotificationServices();

  @override
  void initState() {
    super.initState();
    notificationServices.requestNotificationPermisions();
    notificationServices.isRefreshToken();
    notificationServices.getDeviceToken().then((value) {
      log("not : $value");
    });

    notificationServices.forgroundMessage();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      handleConnectivityChange(result);
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  void handleConnectivityChange(ConnectivityResult result) {
    setState(() {
      hasInternet = result != ConnectivityResult.none;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return UpgradeAlert(
          dialogStyle: Platform.isIOS
              ? UpgradeDialogStyle.cupertino
              : UpgradeDialogStyle.material,
          showIgnore: false,
          showLater: true,
          showReleaseNotes: true,
          child: MaterialApp(
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            title: 'Mediezy Doctor',
            theme: appThemeStyle(context),
            home: const SplashScreen(),
          ),
        );
      },
    );
  }
}
