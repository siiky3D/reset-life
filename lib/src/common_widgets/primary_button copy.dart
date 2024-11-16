import 'package:flutter/material.dart';
import 'package:reset_life/src/constants/app_sizes.dart';

/// Primary button based on [ElevatedButton]. Useful for CTAs in the app.
class PrimaryButton extends StatelessWidget {
  /// Create a PrimaryButton.
  /// if [isLoading] is true, a loading indicator will be displayed instead of
  /// the text.
  const PrimaryButton({
    super.key,
    required this.text,
    this.isLoading = false,
    this.onPressed,
    this.color,
  });
  final String text;
  final bool isLoading;
  final VoidCallback? onPressed;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Sizes.p48,
      child: ElevatedButton(
        onPressed: onPressed,
        child: isLoading
            ? const CircularProgressIndicator()
            : Text(
                text,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: color ?? Colors.white,
                    ),
              ),
      ),
    );
  }
}
