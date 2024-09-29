import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:pegadaian_digital/helpers/colors_custom.dart';
import './onboarding_view_model.dart';

class OnboardingView extends OnboardingViewModel {
  @override
  Widget build(BuildContext context) {
    // Replace this with your build function
    return IntroductionScreen(
        key: introKey,
        globalBackgroundColor: Colors.white,
        allowImplicitScrolling: true,
        autoScrollDuration: 3000,
        pages: pages,
        onDone: () => onDone(),
        onSkip: () => onDone(), // You can override onSkip callback
        showSkipButton: true,
        skipOrBackFlex: 0,
        nextFlex: 0,
        showBackButton: false,
        showNextButton: false,
        showDoneButton: false,
        overrideSkip: SizedBox(),
        //rtl: true, // Display as right-to-left
        curve: Curves.fastLinearToSlowEaseIn,
        controlsPadding: EdgeInsets.only(top: 120),
        dotsDecorator: DotsDecorator(
          size: Size(12.0, 4.0),
          spacing: EdgeInsets.symmetric(horizontal: 3),
          color: ColorsCustom.primary.withOpacity(0.3),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
          activeSize: Size(24.0, 4.0),
          activeColor: ColorsCustom.primary,
          activeShape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
        ),
        globalFooter: globalFooter());
  }

  Widget globalFooter() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buttonFooter(label: "Daftar", isBorder: true),
            const SizedBox(height: 10),
            buttonFooter(label: "Masuk"),
          ],
        ),
      ),
    );
  }

  Widget buttonFooter({required String label, bool isBorder = false}) {
    return SizedBox(
      height: 45,
      child: ElevatedButton(
        style: isBorder
            ? OutlinedButton.styleFrom(
                backgroundColor: ColorsCustom.white,
                side: BorderSide(width: 1, color: ColorsCustom.border),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)),
                elevation: 0)
            : ElevatedButton.styleFrom(
                backgroundColor: ColorsCustom.primary,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6))),
        child: Text(
          label,
          style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: isBorder ? ColorsCustom.black : ColorsCustom.white),
        ),
        onPressed: () {},
      ),
    );
  }
}
