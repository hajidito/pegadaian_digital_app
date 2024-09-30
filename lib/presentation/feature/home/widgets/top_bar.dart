import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pegadaian_digital/presentation/feature/home/bloc/home_bloc.dart';

import '../../../../helpers/colors_custom.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoadingState) {
          return SvgPicture.asset("assets/images/svg/help.svg");
        }

        if (state is HomeErrorState) {
          return SvgPicture.asset("assets/images/svg/booking.svg");
        }

        if (state is HomeLoadedState) {
          return Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Row(
              children: [
                SizedBox(
                  width: 40,
                  height: 40,
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage:
                        AssetImage("assets/images/png/profile_icon.png"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: 'Hi ',
                          style: TextStyle(
                              color: ColorsCustom.black,
                              fontSize: 14,
                              height: 1.5),
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Sahabat!',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 3),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            "assets/images/svg/g-cash.svg",
                            width: 18,
                            height: 18,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            'G-Cash',
                            style: TextStyle(
                                color: ColorsCustom.primary,
                                fontSize: 12,
                                height: 1.5,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 10),
                          SvgPicture.asset(
                            "assets/images/svg/point.svg",
                            width: 18,
                            height: 18,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            '0 Poin',
                            style: TextStyle(
                                color: ColorsCustom.black,
                                fontSize: 12,
                                height: 1.5),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                _helpButton()
              ],
            ),
          );
        }

        return Container();
      },
    );
  }

  Widget _helpButton() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: ColorsCustom.limeBg,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
        ),
        child: Row(
          children: [
            SvgPicture.asset("assets/images/svg/help.svg"),
            const SizedBox(width: 5),
            Text(
              'Pusat\nBantuan',
              style: TextStyle(
                  color: ColorsCustom.primary,
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
            )
          ],
        ));
  }
}
