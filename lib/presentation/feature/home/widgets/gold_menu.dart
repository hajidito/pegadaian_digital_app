import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pegadaian_digital/helpers/colors_custom.dart';

class GoldMenu extends StatelessWidget {
  const GoldMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: ColorsCustom.limeBg,
            ),
            child: Column(
              children: [
                Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                            image: AssetImage(
                                "assets/images/png/gold_menu_bg.png"),
                            fit: BoxFit.cover)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total saldo efektif",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: ColorsCustom.white),
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      text: '10,0000',
                                      style: TextStyle(
                                        color: ColorsCustom.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w800,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: ' gram',
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 24,
                              height: 24,
                              child: IconButton(
                                  style: IconButton.styleFrom(
                                      backgroundColor: ColorsCustom.white,
                                      shape: CircleBorder(),
                                      padding: EdgeInsets.zero),
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.chevron_right,
                                    size: 16,
                                  )),
                            )
                          ],
                        ),
                        SizedBox(height: 8),
                        RichText(
                          text: TextSpan(
                            text: 'Total saldo blokir: ',
                            style: TextStyle(
                                color: ColorsCustom.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600),
                            children: <TextSpan>[
                              TextSpan(
                                  text: '2,0000',
                                  style:
                                      TextStyle(fontWeight: FontWeight.w800)),
                              TextSpan(
                                  text: ' gram',
                                  style:
                                      TextStyle(fontWeight: FontWeight.w800)),
                            ],
                          ),
                        ),
                        SizedBox(height: 15),
                        Row(
                          children: [
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Harga Beli",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: ColorsCustom.white),
                                    ),
                                    const SizedBox(width: 5),
                                    SvgPicture.asset(
                                        "assets/images/svg/chevron-top.svg",
                                        width: 14,
                                        height: 14)
                                  ],
                                ),
                                SizedBox(height: 5),
                                RichText(
                                  text: TextSpan(
                                    text: 'Rp 9.150 ',
                                    style: TextStyle(
                                        color: ColorsCustom.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: '/ 0,01 gr',
                                          style: TextStyle(fontSize: 12)),
                                    ],
                                  ),
                                )
                              ],
                            )),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Harga Jual",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: ColorsCustom.white),
                                    ),
                                    const SizedBox(width: 5),
                                    SvgPicture.asset(
                                        "assets/images/svg/chevron-down.svg",
                                        width: 14,
                                        height: 14)
                                  ],
                                ),
                                SizedBox(height: 5),
                                RichText(
                                  text: TextSpan(
                                    text: 'Rp 8.640 ',
                                    style: TextStyle(
                                        color: ColorsCustom.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: '/ 0,01 gr',
                                          style: TextStyle(fontSize: 12)),
                                    ],
                                  ),
                                )
                              ],
                            ))
                          ],
                        )
                      ],
                    )),
                Row(children: [
                  _buildMenu(title: "Beli", image: "plus"),
                  _buildMenu(title: "Jual", image: "up"),
                  _buildMenu(title: "Gadai", image: "pawn"),
                  _buildMenu(title: "Lainnya", image: "more"),
                ])
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildMenu({required String title, required String image}) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset("assets/images/svg/gold_menu_$image.svg",
                width: 32, height: 32),
            Text(
              title,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: ColorsCustom.black),
            )
          ],
        ),
      ),
    );
  }
}
