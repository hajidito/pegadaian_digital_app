import 'package:flutter/material.dart';
import 'package:pegadaian_digital/helpers/colors_custom.dart';
import 'package:pegadaian_digital/presentation/feature/history/history_screen.dart';
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
  List<(String icon, String label, Widget page)> menu = [];

  int selectedIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  Future<void> initLocal() async {
    PegadaianPreferences pref = getIt.get<PegadaianPreferences>();
    bool isUserLoggedIn = pref.isUserLoggedIn();
    String token = pref.getUserToken() ?? "";
    Logger().d("HOMESCREEN $isUserLoggedIn || $token");
  }

  @override
  void initState() {
    super.initState();
    menu = [
      ("assets/images/svg/home.svg", "Beranda", homeBody()),
      ("assets/images/svg/history.svg", "Riwayat", HistoryScreen()),
      ("assets/images/svg/notification.svg", "Notifikasi", HistoryScreen()),
      ("assets/images/svg/profile.svg", "Profile", HistoryScreen()),
    ];
    initLocal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: menu[selectedIndex].$3,
      bottomNavigationBar: CustomBottomNav(
        menu: menu,
        onTap: onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorsCustom.blue,
        onPressed: () {
          Navigator.of(context).pushNamed('/Attendance');
        },
        child: Icon(Icons.calendar_month_outlined, color: ColorsCustom.white),
      ),
    );
  }

  Widget homeBody() {
    return SafeArea(
      child: ListView(
        children: [
          const SizedBox(height: 20),
          TopBar(),
          GoldMenu(),
          MenuGrid(),
        ],
      ),
    );
  }
}
