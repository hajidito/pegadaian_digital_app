import 'package:flutter/material.dart';
import 'package:pegadaian_digital/presentation/feature/home/widgets/custom_bottom_nav.dart';
import 'package:pegadaian_digital/presentation/feature/home/widgets/gold_menu.dart';
import 'package:pegadaian_digital/presentation/feature/home/widgets/menu_grid.dart';
import 'package:pegadaian_digital/presentation/feature/home/widgets/top_bar.dart';
import 'package:logger/logger.dart';
import 'package:pegadaian_digital/data/pegadaian_preferences.dart';
import 'package:pegadaian_digital/injection.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> initLocal() async {
    PegadaianPreferences pref = getIt.get<PegadaianPreferences>();
    bool isUserLoggedIn = pref.isUserLoggedIn();
    String token = pref.getUserToken() ?? "";
    Logger().d("HOMESCREEN $isUserLoggedIn || $token");
  }

  @override
  void initState() {
    initLocal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.only(top: 20),
          children: [TopBar(), GoldMenu(), MenuGrid()],
        ),
      ),
      bottomNavigationBar: CustomBottomNav(),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.of(context).pushNamed('/Attendance');
      }),
    );
  }
}
