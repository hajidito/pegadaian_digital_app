import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../helpers/colors_custom.dart';
import '../../../injection.dart';
import '../register/bloc/register_bloc.dart';
import '../register/register_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();

  List<PageViewModel> pages = [
    buildPageViewModel(
        title: "Selamat Datang di Pegadaian Digital!",
        desc:
            'Solusi investasi, pendanaan, dan pembayaran tagihan dengan mudah tanpa harus keluar rumah.',
        index: 1),
    buildPageViewModel(
        title: "Investasi Tanpa Cemas",
        desc:
            'Beli dan jual emas dengan fasilitas titipan yang aman karena Pegadaian telah terdaftar dan diawasi oleh OJK. Mulai Rp 50.000, sudah bisa punya emas!',
        index: 2),
    buildPageViewModel(
        title: "Kredit Cepat & Aman",
        desc:
            'Perlu dana tunai yang cepat, aman, dan murah? Jangan jual barang kesayangan kamu. Gadaikan saja di Pegadaian!',
        index: 3,
        supportBtn: "Simulasi Gadai"),
    buildPageViewModel(
        title: "Kembangkan Bisnismu",
        desc:
            'Ciptakan peluang bisnis baru dengan mengajukan pembiayaan yang tepat melalui Pegadaian.',
        index: 4,
        supportBtn: "Simulasi Pinjaman"),
    buildPageViewModel(
        title: "Multi Pembayaran Online",
        desc:
            'Bayar telepon, listrik, air, dan tagihan lainnya melalui aplikasi Pegadaian Digital.',
        index: 5),
  ];

  static PageViewModel buildPageViewModel({
    required String title,
    required String desc,
    required int index,
    String? supportBtn,
  }) {
    return PageViewModel(
      titleWidget: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
            child: Text(title,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: ColorsCustom.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                )),
          ),
        ],
      ),
      bodyWidget: Column(
        children: [
          Text(
            desc,
            textAlign: TextAlign.left,
            style: TextStyle(
              color: ColorsCustom.generalText,
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          ),
          if (supportBtn != null) const SizedBox(height: 10),
          if (supportBtn != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  supportBtn,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ColorsCustom.primary,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: ColorsCustom.black,
                )
              ],
            ),
          const SizedBox(height: 80),
        ],
      ),
      decoration: const PageDecoration(
        imagePadding: EdgeInsets.zero,
        imageFlex: 3,
        bodyFlex: 2,
      ),
      image: SvgPicture.asset(
        "assets/images/svg/illustration_onboarding_$index.svg",
        fit: BoxFit.cover,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Replace this with your build function
    return IntroductionScreen(
        key: introKey,
        globalBackgroundColor: Colors.white,
        allowImplicitScrolling: true,
        autoScrollDuration: 4000,
        pages: pages,
        onDone: () {},
        onSkip: () {}, // You can override onSkip callback
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
        onPressed: () {
          if (label == 'Masuk') {
            // Navigator.of(context).pushReplacement(
            //   MaterialPageRoute(
            //     builder: (_) => BlocProvider(
            //       create: (context) => getIt.get<RegisterBloc>(),
            //       child: RegisterScreen(),
            //     ),
            //   ),
            // );
            Navigator.pushNamed(context, "/Login");
          } else {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => BlocProvider(
                  create: (context) => getIt.get<RegisterBloc>(),
                  child: RegisterScreen(),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
