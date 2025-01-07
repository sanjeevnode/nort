import 'package:flutter/material.dart';
import 'package:nort/constants/button_state.dart';
import 'package:nort/theme/app_colors.dart';
import 'package:nort/theme/app_text_style.dart';

class CustomPrimaryButton extends StatelessWidget {
  const CustomPrimaryButton({
    super.key,
    required this.onPressed,
    this.label = 'Submit',
    this.child,
    this.icon,
    this.textStyle,
    this.borderRadius = 15,
    this.elevation = 0,
    this.buttonState = ButtonState.enable,
    this.padding = const EdgeInsets.symmetric(
      horizontal: 24,
      vertical: 12,
    ),
  });

  final String label;

  final Widget? child;

  final Widget? icon;

  final TextStyle? textStyle;

  final EdgeInsets padding;

  final double borderRadius;

  final double elevation;

  final ButtonState buttonState;

  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (buttonState == ButtonState.enable) ? onPressed : null,
      clipBehavior: Clip.hardEdge,
      style: ElevatedButton.styleFrom(
        elevation: elevation,
        padding: padding,
        backgroundColor: AppColors.primary,
        disabledBackgroundColor: AppColors.primary700,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      child: _buildChild(),
    );
  }

  Widget _buildChild() {
    if (child != null) {
      return child!;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (buttonState == ButtonState.loading) ...[
          const SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.light100),
              backgroundColor: AppColors.light900,
              strokeWidth: 2,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            "Loading...",
            style: textStyle ??
                AppTextStyle.textLgMedium.copyWith(
                  color: AppColors.light100,
                ),
          ),
        ] else ...[
          if (icon != null) ...[
            icon!,
            const SizedBox(width: 8),
          ],
          Text(
            label,
            style: textStyle ??
                AppTextStyle.textLgMedium.copyWith(
                  color: AppColors.light100,
                ),
          ),
        ],
      ],
    );
  }
}
