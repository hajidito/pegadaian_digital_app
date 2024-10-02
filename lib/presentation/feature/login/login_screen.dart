import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:local_auth/local_auth.dart';
import 'package:pegadaian_digital/data/model/request/login_request.dart';
import 'package:pegadaian_digital/helpers/colors_custom.dart';
import 'package:pegadaian_digital/presentation/feature/login/bloc/login_bloc.dart';
import 'package:pegadaian_digital/presentation/widgets/default_button.dart';
import 'package:pegadaian_digital/presentation/widgets/default_text_field.dart';
import 'package:pegadaian_digital/presentation/widgets/loading_dialog.dart';
import 'package:pegadaian_digital/utils/routes.dart';
import 'package:pegadaian_digital/utils/validator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LocalAuthentication auth = LocalAuthentication();

  TextEditingController emailText = TextEditingController();
  bool emailError = false;

  TextEditingController passwordText = TextEditingController();
  bool passwordError = false;

  bool buttonEnabled = false;

  bool saveUserID = false;

  BuildContext? _dialogContext;

  static const successSnackbar = SnackBar(
    content: Text('Berhasil Login'),
  );

  static const failedSnackbar = SnackBar(
    content: Text('Gagal Login'),
  );

  static const noBiometricSnackbar = SnackBar(
    content: Text('Biometric tidak tersedia'),
  );

  void toggleSaveUserID(bool? value) {
    setState(() {
      saveUserID = value!;
    });
  }

  Future<void> onBiometricClick() async {
    final List<BiometricType> availableBiometrics =
        await auth.getAvailableBiometrics();

    if (availableBiometrics.isNotEmpty) {
      bool authenticated = await auth.authenticate(
        localizedReason:
            'Scan your fingerprint (or face or whatever) to authenticate',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );

      if (authenticated) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(successSnackbar);
        // ignore: use_build_context_synchronously
        Navigator.pushReplacementNamed(context, Routes.HOME);
      }
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(noBiometricSnackbar);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: ColorsCustom.primarySoft,
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginLoadingState) {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                _dialogContext = context;
                return PopScope(
                  canPop: false,
                  child: LoadingDialog(),
                );
              },
            );
          }

          if (state is LoginLoadedState) {
            if (_dialogContext != null && _dialogContext!.mounted) {
              Navigator.pop(_dialogContext!);
            }

            ScaffoldMessenger.of(context).showSnackBar(successSnackbar);

            Navigator.pushReplacementNamed(context, Routes.HOME);
          }

          if (state is LoginErrorState) {
            if (_dialogContext != null && _dialogContext!.mounted) {
              Navigator.pop(_dialogContext!);
            }

            ScaffoldMessenger.of(context).showSnackBar(failedSnackbar);
          }
        },
        builder: (context, state) {
          return Stack(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 20),
                              DefaultTextField(
                                textEditingController: emailText,
                                onChanged: (value) {
                                  checkButtonEnabled();
                                  checkEmail();
                                },
                                hintText: "Masukkan alamat email",
                                textInputAction: TextInputAction.next,
                                error: emailError,
                                errorText: "Alamat email tidak valid",
                                icon: Icons.email_outlined,
                              ),
                              SizedBox(height: 10),
                              DefaultTextField(
                                textEditingController: passwordText,
                                password: true,
                                onChanged: (value) {
                                  checkButtonEnabled();
                                  checkPassword();
                                },
                                hintText: "Masukkan kata sandi",
                                textInputAction: TextInputAction.next,
                                error: passwordError,
                                errorText:
                                    "kata sandi harus lebih dari 5 huruf",
                                icon: Icons.lock_outline,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                      onPressed: (buttonEnabled)
                                          ? () {
                                              context.read<LoginBloc>().add(
                                                    LoginClickEvent(
                                                      loginRequest:
                                                          LoginRequest(
                                                        email: emailText.text,
                                                        password:
                                                            passwordText.text,
                                                      ),
                                                    ),
                                                  );
                                            }
                                          : null,
                                      text: "Masuk",
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () => onBiometricClick(),
                                    child: Container(
                                      height: 45,
                                      width: 45,
                                      margin: EdgeInsets.only(left: 10),
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: ColorsCustom.white,
                                        borderRadius: BorderRadius.circular(6),
                                        border: Border.all(
                                            color: ColorsCustom.primary,
                                            width: 1),
                                      ),
                                      child: SvgPicture.asset(
                                          "assets/images/svg/ic_biometric.svg"),
                                    ),
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
                                    fontSize: 14,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: 'Daftar',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: ColorsCustom.primary),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.pushNamed(
                                            context,
                                            Routes.REGISTER,
                                          );
                                        },
                                    ),
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
                ),
              )
            ],
          );
        },
      ),
    );
  }

  void checkButtonEnabled() {
    if (validateEmail(emailText.text) && passwordText.text.length >= 6) {
      setState(() {
        buttonEnabled = true;
      });
    } else {
      setState(() {
        buttonEnabled = false;
      });
    }
  }

  void checkEmail() {
    if (validateEmail(emailText.text)) {
      setState(() {
        emailError = false;
      });
    } else {
      setState(() {
        emailError = true;
      });
    }
  }

  void checkPassword() {
    if (passwordText.text.length >= 6) {
      setState(() {
        passwordError = false;
      });
    } else {
      setState(() {
        passwordError = true;
      });
    }
  }

  @override
  void dispose() {
    emailText.dispose();
    passwordText.dispose();
    super.dispose();
  }
}
