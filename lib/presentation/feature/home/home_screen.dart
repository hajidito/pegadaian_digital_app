import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pegadaian_digital/helpers/colors_custom.dart';
import 'package:pegadaian_digital/presentation/feature/history/history_screen.dart';
import 'package:pegadaian_digital/presentation/feature/home/bloc/home_bloc.dart';
import 'package:pegadaian_digital/presentation/feature/home/widgets/custom_bottom_nav.dart';
import 'package:pegadaian_digital/presentation/feature/home/widgets/gold_menu.dart';
import 'package:pegadaian_digital/presentation/feature/home/widgets/menu_grid.dart';
import 'package:pegadaian_digital/presentation/feature/home/widgets/top_bar.dart';
import 'package:pegadaian_digital/utils/routes.dart';

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

  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(GetUserEvent());
    menu = [
      ("assets/images/svg/home.svg", "Beranda", homeBody()),
      ("assets/images/svg/history.svg", "Riwayat", HistoryScreen()),
      ("assets/images/svg/notification.svg", "Notifikasi", HistoryScreen()),
      ("assets/images/svg/profile.svg", "Profile", HistoryScreen()),
    ];
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
          Navigator.pushNamed(context, Routes.ATTENDANCE);
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
