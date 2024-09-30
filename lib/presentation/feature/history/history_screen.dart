import 'package:flutter/material.dart';
import 'package:pegadaian_digital/presentation/feature/history/widgets/list_history.dart';

import '../../../helpers/colors_custom.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        title: Text("History"),
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(
              color: ColorsCustom.borderSoft,
              height: 1.0,
            )),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            ListHistory(
              isToday: true,
              checkIn: DateTime.now().subtract(Duration(days: 2, hours: 3)),
              checkOut: DateTime.now().subtract(Duration(days: 2)),
            ),
            ListHistory(
              isToday: false,
              checkIn: DateTime.now().subtract(Duration(days: 1, hours: 3)),
              checkOut: DateTime.now().subtract(Duration(days: 1, hours: 3)),
            ),
            ListHistory(
              isToday: false,
              checkIn: DateTime.now().subtract(Duration(hours: 3)),
              checkOut: DateTime.now(),
            ),
          ],
        ),
      ),
    );
  }
}
