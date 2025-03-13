import 'package:flutter/material.dart';
import 'package:nort/core/core.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.onPressed,
    this.label = 'Submit',
    this.child,
    this.icon,
    this.textStyle,
    this.borderRadius = 15,
    this.elevation = 0,
    this.style,
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

  final ButtonStyle? style;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (buttonState == ButtonState.enable) ? onPressed : null,
      clipBehavior: Clip.hardEdge,
      style: style ??
          ElevatedButton.styleFrom(
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

class OutlineButton extends PrimaryButton {
  OutlineButton({
    super.key,
    required super.onPressed,
    super.label = 'Submit',
    super.child,
    super.icon,
    super.borderRadius = 15,
    super.elevation = 0,
    super.padding = const EdgeInsets.symmetric(
      horizontal: 24,
      vertical: 12,
    ),
    super.buttonState = ButtonState.enable,
  }) : super(
          style: ElevatedButton.styleFrom(
            side: const BorderSide(color: AppColors.primary700, width: 1),
            backgroundColor: AppColors.light100,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            padding: padding,
            elevation: elevation,
          ),
          textStyle: AppTextStyle.textLgMedium.copyWith(
            color: AppColors.primary700,
          ),
        );
}
