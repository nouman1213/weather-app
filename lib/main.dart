import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:weather_app/screens/home_screen.dart';
import 'package:weather_app/screens/splash.dart';

dynamic components() {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // components();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(
    DevicePreview(
      enabled: true,
      // ignore: prefer_const_literals_to_create_immutables
      tools: [
        ...DevicePreview.defaultTools,
      ],
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'weather_App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'poppins',
        ),
        debugShowCheckedModeBanner: false,
        home: const HomeScreen(),
        builder: (_, child) =>
            ScrollConfiguration(behavior: AppBehavior(), child: child!));
  }
}

///Disable GLow effect
class AppBehavior extends ScrollBehavior {
  @override
  buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
