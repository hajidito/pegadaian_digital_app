import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:pegadaian_digital/helpers/colors_custom.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './onboarding.dart';

abstract class OnboardingViewModel extends State<Onboarding> {
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

  Future<void> onDone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('introduction', true);

    // ignore: use_build_context_synchronously
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/Landing', (Route<dynamic> route) => false);
  }
}
