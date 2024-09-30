import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../helpers/colors_custom.dart';

class MenuGrid extends StatefulWidget {
  const MenuGrid({super.key});

  @override
  State<MenuGrid> createState() => _MenuGridState();
}

class _MenuGridState extends State<MenuGrid> {
  List<(String image, String title)> menuList = [
    ("assets/images/svg/pawn.svg", "Bayar Gadai"),
    ("assets/images/svg/instalment.svg", "Bayar Cicilan"),
    ("assets/images/svg/credit.svg", "Pulsa & Paket Data"),
    ("assets/images/svg/gold_plus.svg", "Tab. Emas Plus"),
    ("assets/images/svg/booking.svg", "Booking Service"),
    ("assets/images/svg/pln.svg", "Listrik (PLN)"),
    ("assets/images/svg/gold_bar.svg", "Cicilan Emas Batangan"),
    ("assets/images/svg/menu.svg", "Lihat Semua"),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 5,
              childAspectRatio: 0.8,
              crossAxisSpacing: 5),
          itemCount: menuList.length,
          itemBuilder: (context, index) {
            return Container(
                width: 60,
                height: 80,
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  children: [
                    SvgPicture.asset(menuList[index].$1),
                    SizedBox(height: 10),
                    Text(
                      menuList[index].$2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: ColorsCustom.black),
                    ),
                  ],
                ));
          }),
    );
  }
}
