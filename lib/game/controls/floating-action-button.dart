import 'package:flutter/material.dart';

import '../style/color-palette.dart';

class DarthFloatingActionButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;

  const DarthFloatingActionButton({
    Key? key,
    required this.onPressed,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      child: child,
      backgroundColor: ColorPalette.clouds,
      foregroundColor: ColorPalette.midnightBlue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(color: ColorPalette.wetAsphalt, width: 5), // Kolor ramki
      ),
    );
  }
}