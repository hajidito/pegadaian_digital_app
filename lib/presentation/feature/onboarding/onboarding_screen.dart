import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pegadaian_digital/injection.dart';
import 'package:pegadaian_digital/presentation/feature/register/bloc/register_bloc.dart';
import 'package:pegadaian_digital/presentation/feature/register/register_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
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
            OutlinedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (_) => BlocProvider(
                      create: (context) => getIt.get<RegisterBloc>(),
                      child: RegisterScreen(),
                    ),
                  ),
                );
              },
              child: Text("Daftar"),
            ),
            SizedBox(height: 16),
            FilledButton(onPressed: () {}, child: Text("Masuk")),
            SizedBox(height: 24),
          ],
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
