import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DefaultTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final Function(String) onChanged;
  final Function(String)? onSubmitted;
  final String hintText;
  final TextInputAction textInputAction;
  final bool enabled;
  final bool error;
  final String errorText;

  const DefaultTextField({
    super.key,
    required this.textEditingController,
    required this.onChanged,
    required this.hintText,
    this.onSubmitted,
    this.textInputAction = TextInputAction.done,
    this.enabled = true,
    this.error = false,
    this.errorText = "",
  });

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    ColorScheme colorScheme = themeData.colorScheme;

    InputDecoration ok() {
      return InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colorScheme.outline),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        focusColor: colorScheme.onSurface,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colorScheme.secondary),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        filled: true,
        fillColor: colorScheme.surfaceVariant,
        hintText: hintText,
        hintStyle: themeData.textTheme.bodyMedium?.copyWith(
          color: colorScheme.outline,
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 12,
        ),
        isDense: true,
      );
    }

    InputDecoration disabled() {
      return InputDecoration(
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colorScheme.outline),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        filled: true,
        fillColor: colorScheme.background,
        hintText: hintText,
        hintStyle: themeData.textTheme.bodyMedium?.copyWith(
          color: colorScheme.outline,
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 12,
        ),
        isDense: true,
      );
    }

    return Column(
      children: [
        TextField(
          controller: textEditingController,
          onChanged: enabled ? onChanged : null,
          onSubmitted: onSubmitted,
          style: themeData.textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurface,
          ),
          textInputAction: textInputAction,
          cursorColor: colorScheme.onSurface,
          decoration: enabled ? ok() : disabled(),
          enabled: enabled,
        ),
        SizedBox(
          height: 8,
        ),
        error
            ? Row(
                children: [
                  SvgPicture.asset(
                    "assets/ic_error_text_field.svg",
                    width: 12,
                    height: 12,
                  ),
                  SizedBox(width: 5),
                  Text(
                    errorText,
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
