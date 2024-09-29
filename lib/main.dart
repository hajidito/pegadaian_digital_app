import 'package:flutter/material.dart';
import 'package:pegadaian_digital/helpers/colors_custom.dart';
import 'package:pegadaian_digital/injection.dart';
import 'package:pegadaian_digital/presentation/feature/splash/splash_screen.dart';
import 'package:pegadaian_digital/routes.dart';

import 'injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  await getIt.allReady();

  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pegadaian Digital',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: ColorsCustom.primary),
          titleTextStyle: TextStyle(
              color: ColorsCustom.black,
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
        useMaterial3: true,
      ),
      home: SplashScreen(),
      routes: routes,
    );
  }
}
