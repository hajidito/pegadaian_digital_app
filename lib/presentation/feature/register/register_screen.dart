import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pegadaian_digital/data/model/request/register_request.dart';
import 'package:pegadaian_digital/helpers/colors_custom.dart';
import 'package:pegadaian_digital/presentation/feature/register/bloc/register_bloc.dart';
import 'package:pegadaian_digital/presentation/widgets/default_button.dart';
import 'package:pegadaian_digital/presentation/widgets/default_password_text_field.dart';
import 'package:pegadaian_digital/presentation/widgets/default_text_field.dart';
import 'package:pegadaian_digital/presentation/widgets/loading_dialog.dart';
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

  BuildContext? _dialogContext;

  static const successSnackbar = SnackBar(
    content: Text('Berhasil Mendaftar'),
  );

  static const failedSnackbar = SnackBar(
    content: Text('Gagal Mendaftar'),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text("Daftar"),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: ColorsCustom.borderSoft,
            height: 1.0,
          ),
        ),
      ),
      body: SafeArea(
        child: BlocConsumer<RegisterBloc, RegisterState>(
          listener: (context, state) {
            if (state is RegisterLoadingState) {
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

            if (state is RegisterLoadedState) {
              if (_dialogContext != null && _dialogContext!.mounted) {
                Navigator.pop(_dialogContext!);
              }

              ScaffoldMessenger.of(context).showSnackBar(successSnackbar);
            }

            if (state is RegisterErrorState) {
              if (_dialogContext != null && _dialogContext!.mounted) {
                Navigator.pop(_dialogContext!);
              }

              ScaffoldMessenger.of(context).showSnackBar(failedSnackbar);
            }
          },
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      children: [
                        Text(
                          'Selamat Datang!',
                          style: TextStyle(
                            color: ColorsCustom.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Lengkapi informasi untuk mulai investasi, gadai dan transaksi finansial lainnya.',
                          style: TextStyle(
                            color: ColorsCustom.generalText,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Nama Lengkap',
                          style: TextStyle(
                            color: ColorsCustom.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        DefaultTextField(
                          textEditingController: nameText,
                          onChanged: (value) {
                            checkButtonEnabled();
                            checkName();
                          },
                          hintText: "Masukkan nama lengkap",
                          textInputAction: TextInputAction.next,
                          error: nameError,
                          errorText: "Nama tidak valid",
                          icon: Icons.person_outline,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Nomor Handphone',
                          style: TextStyle(
                            color: ColorsCustom.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        DefaultTextField(
                          textEditingController: phoneText,
                          onChanged: (value) {
                            checkButtonEnabled();
                            checkPhone();
                          },
                          hintText: "Masukkan nomor handphone",
                          textInputAction: TextInputAction.next,
                          error: phoneError,
                          errorText: "Nomor handphone tidak valid",
                          icon: Icons.phone_outlined,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Email',
                          style: TextStyle(
                            color: ColorsCustom.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
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
                        Text(
                          'Kata Sandi',
                          style: TextStyle(
                            color: ColorsCustom.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        DefaultPasswordTextField(
                          textEditingController: passwordText,
                          onChanged: (value) {
                            checkButtonEnabled();
                            checkPassword();
                          },
                          hintText: "Masukkan kata sandi",
                          error: passwordError,
                          errorText: "kata sandi harus lebih dari 5 huruf",
                        ),
                        SizedBox(height: 10),
                        RichText(
                          text: TextSpan(
                            text: 'Dengan melanjutkan kamu setuju dengan ',
                            style: TextStyle(
                              color: ColorsCustom.generalText,
                              fontSize: 14,
                              height: 1.5,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Syarat & Ketentuan',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: ColorsCustom.primary,
                                ),
                              ),
                              TextSpan(text: " dan "),
                              TextSpan(
                                text: 'Kebijakan Privasi',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: ColorsCustom.primary,
                                ),
                              ),
                              TextSpan(text: " yang berlaku."),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DefaultButton(
                        onPressed: (buttonEnabled)
                            ? () {
                                context.read<RegisterBloc>().add(
                                      RegisterClickEvent(
                                        registerRequest: RegisterRequest(
                                          name: nameText.text,
                                          email: emailText.text,
                                          phone: phoneText.text,
                                          password: passwordText.text,
                                        ),
                                      ),
                                    );
                              }
                            : null,
                        text: "Daftar",
                      ),
                      SizedBox(height: 12),
                      RichText(
                        text: TextSpan(
                          text: 'Sudah Punya Akun? ',
                          style: TextStyle(
                              color: ColorsCustom.generalText, fontSize: 14),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Masuk',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: ColorsCustom.primary,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void checkButtonEnabled() {
    if (nameText.text.isNotEmpty &&
        phoneText.text.isNotEmpty &&
        validateEmail(emailText.text) &&
        passwordText.text.length >= 6) {
      setState(() {
        buttonEnabled = true;
      });
    } else {
      setState(() {
        buttonEnabled = false;
      });
    }
  }

  void checkName() {
    if (nameText.text.isNotEmpty) {
      setState(() {
        nameError = false;
      });
    } else {
      setState(() {
        nameError = true;
      });
    }
  }

  void checkPhone() {
    if (phoneText.text.isNotEmpty) {
      setState(() {
        phoneError = false;
      });
    } else {
      setState(() {
        phoneError = true;
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
