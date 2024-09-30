import 'package:flutter/material.dart';
import 'package:pegadaian_digital/presentation/feature/home/home_screen.dart';
import 'package:pegadaian_digital/presentation/feature/login/login_screen.dart';
import 'package:pegadaian_digital/presentation/feature/onboarding/onboarding_screen.dart';
import 'package:pegadaian_digital/presentation/feature/register/register_screen.dart';

final Map<String, WidgetBuilder> routes = {
  '/Onboarding': (BuildContext context) => const OnboardingScreen(),
  '/Register': (BuildContext context) => const RegisterScreen(),
  '/Login': (BuildContext context) => const LoginScreen(),
  '/Home': (BuildContext context) => const HomeScreen(),
};
