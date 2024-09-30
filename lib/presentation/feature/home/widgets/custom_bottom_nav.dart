import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pegadaian_digital/helpers/colors_custom.dart';

class CustomBottomNav extends StatelessWidget {
  const CustomBottomNav({super.key});

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
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 11,
        unselectedFontSize: 11,
        backgroundColor: ColorsCustom.white,
        elevation: 5,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/images/svg/home.svg"),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/images/svg/history.svg"),
            label: 'Riwayat',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/images/svg/notification.svg"),
            label: 'Notifikasi',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/images/svg/profile.svg"),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
