import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pegadaian_digital/helpers/colors_custom.dart';

class DefaultButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final String? initialIconPath;
  final bool isMedium;
  final bool isLarge;
  final double? elevation;

  const DefaultButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.initialIconPath,
    this.isMedium = true,
    this.isLarge = false,
    this.elevation,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    ColorScheme colorScheme = themeData.colorScheme;

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          backgroundColor: ColorsCustom.primary,
          disabledBackgroundColor: colorScheme.outline,
          elevation: elevation),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: (isMedium == true)
              ? 8
              : (isLarge == true)
                  ? 16
                  : 8,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon(
              colorScheme.onSecondary,
            ),
            Text(
              text,
              style: themeData.textTheme.labelLarge?.copyWith(
                  color: (onPressed != null)
                      ? colorScheme.onSecondary
                      : colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget icon(Color color) {
    if (initialIconPath != null) {
      return Row(
        children: [
          SvgPicture.asset(
            initialIconPath ?? "",
            colorFilter: ColorFilter.mode(
              color,
              BlendMode.srcIn,
            ),
            semanticsLabel: 'initial icon',
            width: (isLarge == true) ? 24 : 20,
            height: (isLarge == true) ? 24 : 20,
          ),
          SizedBox(width: 12),
        ],
      );
    } else {
      return Container();
    }
  }
}
