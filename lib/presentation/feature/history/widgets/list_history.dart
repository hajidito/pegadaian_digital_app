import 'package:flutter/material.dart';
import 'package:pegadaian_digital/helpers/colors_custom.dart';
import 'package:pegadaian_digital/helpers/date_formatter.dart';

class ListHistory extends StatelessWidget {
  const ListHistory({super.key, required this.checkIn, required this.checkOut});

  final DateTime checkIn;
  final DateTime checkOut;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      height: 100,
      decoration: BoxDecoration(
        color: ColorsCustom.cloud,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ColorsCustom.primary,
            ),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(CustomDateFormatter.getDate(checkIn),
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: ColorsCustom.white)),
                Text(CustomDateFormatter.getDay(checkIn),
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: ColorsCustom.white)),
              ],
            ),
          ),
          const SizedBox(width: 30),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    "Check In",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: ColorsCustom.black),
                  ),
                ),
                const SizedBox(height: 5),
                Flexible(
                  child: Text(
                    "${CustomDateFormatter.getTime(checkIn)} WIB",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: ColorsCustom.greyText),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    "Check Out",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: ColorsCustom.black),
                  ),
                ),
                const SizedBox(height: 5),
                Flexible(
                  child: Text(
                    "${CustomDateFormatter.getTime(checkOut)} WIB",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: ColorsCustom.greyText),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
