import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pegadaian_digital/screens/home/home.dart';
import 'package:pegadaian_digital/screens/onboarding/onboarding.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../landing/landing.dart';
import './splash.dart';

abstract class SplashViewModel extends State<Splash>
    with SingleTickerProviderStateMixin {
  bool introduction = false;
  bool isLogin = false;
  bool noPermissionLocation = false;

  Future<void> checkLocationPermission() async {
    if (introduction) {
      if (await Permission.location.request().isGranted) {
        if (kDebugMode) {
          print("Permission Granted");
        }
      } else {
        if (kDebugMode) {
          print("Permission Denied");
        }
        setState(() {
          noPermissionLocation = true;
        });
      }
    }
  }

  Future<void> initLocal() async {
    final prefs = await SharedPreferences.getInstance();
    bool checkIntro = prefs.getBool("introduction") ?? false;
    bool checkIsLogin = prefs.getBool("is_login") ?? false;

    setState(() {
      introduction = checkIntro;
      isLogin = checkIsLogin;
    });
  }

  void checkNavigation() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
          builder: (_) => !introduction
              ? const Onboarding()
              : isLogin
                  ? const Home()
                  : const Landing()),
    );
  }

  @override
  void initState() {
    initLocal();
    checkLocationPermission();
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(seconds: 2), () => checkNavigation());
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    super.dispose();
  }
}
