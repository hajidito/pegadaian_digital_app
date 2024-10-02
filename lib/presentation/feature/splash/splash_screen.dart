import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pegadaian_digital/data/pegadaian_preferences.dart';
import 'package:pegadaian_digital/injection.dart';
import 'package:pegadaian_digital/utils/routes.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
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
    PegadaianPreferences pref = getIt.get<PegadaianPreferences>();
    bool isUserLoggedIn = pref.isUserLoggedIn();
    setState(() {
      isLogin = isUserLoggedIn;
    });
  }

  void checkNavigation() {
    String route = (isLogin) ? Routes.HOME : Routes.ONBOARDING;
    Navigator.pushReplacementNamed(context, route);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/images/svg/ic_logo.svg',
              width: 150,
              height: 150,
              semanticsLabel: 'logo',
            )
          ],
        ),
      ),
    );
  }
}
