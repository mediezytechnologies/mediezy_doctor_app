import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_doctor/Ui/Consts/app_theme_style.dart';
import 'package:mediezy_doctor/Ui/Consts/bloc_providers.dart';
import 'package:mediezy_doctor/Ui/Screens/AuthenticationsScreens/SplashScreen/splash_screen.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: AppBBlocProviders.allBlocProviders,
      child: const MediezyDoctor(),
    ),
  );
}

class MediezyDoctor extends StatelessWidget {
  const MediezyDoctor({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Mediezy Doctor',
          theme: appThemeStyle(),
          home: const SplashScreen(),
        );
      },
    );
  }
}
