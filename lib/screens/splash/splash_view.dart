import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import './splash_view_model.dart';

class SplashView extends SplashViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/images/svg/ic_logo.svg',
              width: 150,
              height: 150,
              semanticsLabel: 'logo',
            )
          ],
        ),
      ),
    );
  }
}
