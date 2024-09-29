import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pegadaian_digital/helpers/colors_custom.dart';

import '../../../injection.dart';
import '../../widget/default_button.dart';
import '../../widget/default_text_field.dart';
import '../register/bloc/register_bloc.dart';
import '../register/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailText = TextEditingController();
  TextEditingController passwordText = TextEditingController();

  bool emailError = false;
  bool passwordError = false;
  bool saveUserID = false;

  void toggleSaveUserID(bool? value) {
    setState(() {
      saveUserID = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: ColorsCustom.primarySoft,
      body: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
          ),
          SizedBox(
            width: screenSize.width,
            height: screenSize.width - 80,
            child: SvgPicture.asset(
              "assets/images/svg/login_bg.svg",
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
              top: screenSize.width - 100,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                decoration: BoxDecoration(
                  color: ColorsCustom.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: SafeArea(
                  top: false,
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Masuk",
                                  style: TextStyle(
                                      color: ColorsCustom.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      height: 1.5),
                                ),
                                SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircleAvatar(
                                      backgroundColor: ColorsCustom.greyText,
                                      child: Icon(
                                        Icons.question_mark_rounded,
                                        size: 11,
                                        color: ColorsCustom.white,
                                      )),
                                )
                              ],
                            ),
                            SizedBox(height: 20),
                            DefaultTextField(
                              textEditingController: emailText,
                              onChanged: (value) {},
                              hintText: "Nomor handphone / email",
                              textInputAction: TextInputAction.next,
                              error: emailError,
                              errorText: "Nomor handphone / email tidak valid",
                              icon: Icons.email_outlined,
                            ),
                            SizedBox(height: 10),
                            DefaultTextField(
                              textEditingController: emailText,
                              password: true,
                              onChanged: (value) {},
                              hintText: "Password",
                              textInputAction: TextInputAction.next,
                              error: emailError,
                              errorText: "Password tidak valid",
                              icon: Icons.lock_outline,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Checkbox(
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      activeColor: ColorsCustom.primary,
                                      value: saveUserID,
                                      onChanged: (v) => toggleSaveUserID(v),
                                    ),
                                    Text(
                                      "Simpan User ID",
                                      style: TextStyle(
                                        color: ColorsCustom.generalText,
                                        fontSize: 14,
                                      ),
                                    )
                                  ],
                                ),
                                Text(
                                  "Lupa Password?",
                                  style: TextStyle(
                                    color: ColorsCustom.primary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                Expanded(
                                  child: DefaultButton(
                                    onPressed: () {},
                                    text: "Masuk",
                                  ),
                                ),
                                Container(
                                  height: 45,
                                  width: 45,
                                  margin: EdgeInsets.only(left: 10),
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: ColorsCustom.white,
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(
                                        color: ColorsCustom.primary, width: 1),
                                  ),
                                  child: SvgPicture.asset(
                                      "assets/images/svg/ic_biometric.svg"),
                                )
                              ],
                            ),
                            SizedBox(height: 20),
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                text: 'Belum Punya Akun? ',
                                style: TextStyle(
                                    color: ColorsCustom.generalText,
                                    fontSize: 14),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: 'Daftar',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: ColorsCustom.primary),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                              builder: (_) => BlocProvider(
                                                create: (context) =>
                                                    getIt.get<RegisterBloc>(),
                                                child: RegisterScreen(),
                                              ),
                                            ),
                                          );
                                        }),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Text(
                        "Versi 0.0.1",
                        style: TextStyle(
                          color: ColorsCustom.greyText,
                          fontSize: 9,
                        ),
                      )
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
