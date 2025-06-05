import 'package:binevir/constants/theme_colors.dart';
import 'package:flutter/Material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({super.key, this.onPressed, required this.child});

  final Function()? onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: ThemeColors.red, //dow Color
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}