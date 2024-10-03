import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pegadaian_digital/features/login/login_screen.dart';
import 'package:pegadaian_digital/features/register/bloc/register_bloc.dart';
import 'package:pegadaian_digital/features/register/register_screen.dart';
import 'package:pegadaian_digital/helpers/colors_custom.dart';
import 'package:pegadaian_digital/injection.dart';
import 'package:pegadaian_digital/presentation/feature/home/home_screen.dart';
import 'package:pegadaian_digital/presentation/feature/onboarding/onboarding_screen.dart';
import 'package:pegadaian_digital/presentation/feature/splash/splash_screen.dart';
import 'package:pegadaian_digital/utils/route_observer.dart';
import 'package:pegadaian_digital/utils/routes.dart';

import 'features/login/bloc/login_bloc.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider<RegisterBloc>(
            create: (BuildContext context) =>
                getIt.get<RegisterBloc>()
        ),
        BlocProvider<LoginBloc>(
            create: (BuildContext context) =>
                getIt.get<LoginBloc>()
        )
      ],
      child: MaterialApp(
        title: 'Pegadaian Digital',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen),
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: false,
            iconTheme: IconThemeData(color: ColorsCustom.primary),
            titleTextStyle: TextStyle(
                color: ColorsCustom.black,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
          useMaterial3: true,
        ),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case Routes.ONBOARDING:
              return MaterialPageRoute(builder: (_) => OnboardingScreen());
            case Routes.HOME:
              return MaterialPageRoute(builder: (_) => HomeScreen());
            case Routes.REGISTER:
              return MaterialPageRoute(builder: (_) => RegisterScreen());
            case Routes.LOGIN:
              return MaterialPageRoute(builder: (_) => LoginScreen());
            default:
              return MaterialPageRoute(
                builder: (_) {
                  return const Scaffold(
                    body: Center(
                      child: Text('Page not found :('),
                    ),
                  );
                },
              );
          }
        },
        home: SplashScreen(),
      ),
    );
  }
}
