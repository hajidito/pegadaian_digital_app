import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pegadaian_digital/helpers/colors_custom.dart';
import 'package:pegadaian_digital/presentation/widgets/tap_effect.dart';

class DefaultPasswordTextField extends StatefulWidget {
  final TextEditingController textEditingController;
  final Function(String) onChanged;
  final Function(String)? onSubmitted;
  final String hintText;
  final bool error;
  final String errorText;

  const DefaultPasswordTextField({
    super.key,
    required this.textEditingController,
    required this.onChanged,
    required this.hintText,
    this.onSubmitted,
    this.error = false,
    this.errorText = "",
  });

  @override
  State<DefaultPasswordTextField> createState() =>
      _DefaultPasswordTextFieldState();
}

class _DefaultPasswordTextFieldState extends State<DefaultPasswordTextField> {
  bool isObscureText = true;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    ColorScheme colorScheme = themeData.colorScheme;

    InputDecoration ok() {
      return InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorsCustom.borderSoft),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        focusColor: colorScheme.onSurface,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorsCustom.border),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        filled: true,
        fillColor: ColorsCustom.white,
        hintText: widget.hintText,
        hintStyle: themeData.textTheme.bodyMedium?.copyWith(
          color: colorScheme.outline,
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 12,
        ),
        isDense: true,
        suffixIconConstraints: BoxConstraints(
          maxHeight: 44,
          maxWidth: 36,
        ),
        suffixIcon: TapEffect(
          onTap: () {
            setState(() {
              isObscureText = !isObscureText;
            });
          },
          borderRadiusSize: 4,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 12,
            ),
            child: SvgPicture.asset(
              (isObscureText == true)
                  ? "assets/ic_password_hide.svg"
                  : "assets/ic_password_show.svg",
              colorFilter: ColorFilter.mode(
                ColorsCustom.black,
                BlendMode.srcIn,
              ),
              height: 20,
              width: 20,
            ),
          ),
        ),
      );
    }

    return Column(
      children: [
        TextField(
          controller: widget.textEditingController,
          onChanged: widget.onChanged,
          onSubmitted: widget.onSubmitted,
          style: themeData.textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurface,
          ),
          textInputAction: TextInputAction.done,
          cursorColor: colorScheme.onSurface,
          decoration: ok(),
          obscureText: isObscureText,
        ),
        SizedBox(
          height: 8,
        ),
        widget.error
            ? Row(
                children: [
                  SvgPicture.asset(
                    "assets/ic_error_text_field.svg",
                    width: 12,
                    height: 12,
                  ),
                  SizedBox(width: 5),
                  Text(
                    widget.errorText,
                    style: themeData.textTheme.labelSmall
                        ?.copyWith(color: colorScheme.error),
                  )
                ],
              )
            : Container(),
      ],
    );
  }
}
