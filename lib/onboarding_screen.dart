import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 36),
            AspectRatio(
              aspectRatio: 3 / 2,
              child: Container(
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage('assets/illustration_onboarding_1.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 24),
            Text("Selamat Datang di Pegadaian Digital!"),
            Text(
                "Solusi investasi, pendanaan, dan pembayaran tagihan dengan mudah tanpa harus keluar rumah."),
            Expanded(flex: 1, child: SizedBox()),
            OutlinedButton(onPressed: () {}, child: Text("Daftar")),
            SizedBox(height: 16),
            FilledButton(onPressed: () {}, child: Text("Masuk")),
            SizedBox(height: 24),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
