import 'package:flutter/material.dart';
import 'package:pegadaian_digital/helpers/colors_custom.dart';

class DefaultButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;

  const DefaultButton({
    super.key,
    required this.onPressed,
    required this.text,
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
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 8,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: themeData.textTheme.labelLarge?.copyWith(
                color: (onPressed != null)
                    ? colorScheme.onSecondary
                    : colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
