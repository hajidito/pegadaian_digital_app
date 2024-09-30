import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pegadaian_digital/helpers/colors_custom.dart';

class CustomBottomNav extends StatelessWidget {
  const CustomBottomNav({super.key, required this.menu, required this.onTap});

  final List<(String icon, String label, Widget page)> menu;
  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: ColorsCustom.borderSoft,
            width: 0.5,
          ),
        ),
      ),
      child: BottomNavigationBar(
        onTap: onTap,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 11,
        unselectedFontSize: 11,
        backgroundColor: ColorsCustom.white,
        elevation: 5,
        items: menu.map((item) {
          return BottomNavigationBarItem(
            icon: SvgPicture.asset(
              item.$1,
              width: 20,
              height: 20,
            ),
            label: item.$2,
          );
        }).toList(),
      ),
    );
  }
}
