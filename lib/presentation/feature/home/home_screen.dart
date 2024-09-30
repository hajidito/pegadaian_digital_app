import 'package:flutter/material.dart';
import 'package:pegadaian_digital/presentation/feature/home/widgets/custom_bottom_nav.dart';
import 'package:pegadaian_digital/presentation/feature/home/widgets/gold_menu.dart';
import 'package:pegadaian_digital/presentation/feature/home/widgets/menu_grid.dart';
import 'package:pegadaian_digital/presentation/feature/home/widgets/top_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: ListView(
            padding: EdgeInsets.only(top: 20),
            children: [TopBar(), GoldMenu(), MenuGrid()],
          ),
        ),
        bottomNavigationBar: CustomBottomNav());
  }
}
