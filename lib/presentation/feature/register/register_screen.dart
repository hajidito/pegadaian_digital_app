import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:pegadaian_digital/data/model/request/register_request.dart';
import 'package:pegadaian_digital/presentation/feature/register/bloc/register_bloc.dart';
import 'package:pegadaian_digital/presentation/widget/default_button.dart';
import 'package:pegadaian_digital/presentation/widget/default_text_field.dart';
import 'package:pegadaian_digital/utils/validator.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameText = TextEditingController();
  bool nameError = false;

  TextEditingController phoneText = TextEditingController();
  bool phoneError = false;

  TextEditingController emailText = TextEditingController();
  bool emailError = false;

  TextEditingController passwordText = TextEditingController();
  bool passwordError = false;

  bool buttonEnabled = false;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    ColorScheme colorScheme = themeData.colorScheme;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text("Daftar"),
        ),
        body: BlocConsumer<RegisterBloc, RegisterState>(
          listener: (context, state) {
            if (state is RegisterLoadingState) {
              Logger().i("register loading");
            }

            if (state is RegisterLoadedState) {
              Logger().i("register loaded");
            }

            if (state is RegisterErrorState) {
              Logger().i("register error");
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                Text(
                  'Email/Username',
                  style: TextStyle(
                    color: colorScheme.onSurface,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                DefaultTextField(
                  textEditingController: emailText,
                  onChanged: (value) {
                    checkButtonEnabled();
                    checkEmail();
                  },
                  hintText: "Masukkan email/username",
                  textInputAction: TextInputAction.next,
                  error: emailError,
                  errorText: "Alamat email tidak valid",
                ),
                SizedBox(
                  height: 8,
                ),
                DefaultButton(
                  onPressed: () {
                    context.read<RegisterBloc>().add(
                          RegisterClickEvent(
                            registerRequest: RegisterRequest(
                                name: "nama",
                                email: "nauffff@gmail.com",
                                phone: "08080808080",
                                password: "password1234"),
                          ),
                        );
                  },
                  text: "Daftar",
                )
              ],
            );
          },
        ),
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
    nameText.dispose();
    phoneText.dispose();
    emailText.dispose();
    passwordText.dispose();
    super.dispose();
  }
}
