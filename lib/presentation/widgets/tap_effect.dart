import 'package:flutter/material.dart';

class TapEffect extends StatelessWidget {
  final void Function() onTap;
  final double borderRadiusSize;
  final Widget child;
  final Color color;

  const TapEffect({
    super.key,
    required this.onTap,
    required this.borderRadiusSize,
    required this.child,
    this.color = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(borderRadiusSize),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(borderRadiusSize),
        child: child,
      ),
    );
  }
}
