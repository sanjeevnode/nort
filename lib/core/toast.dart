import 'package:flutter/material.dart';

import 'core.dart';

class Toast {
  static final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  static GlobalKey<ScaffoldMessengerState> get scaffoldKey => _scaffoldKey;

  static const _defaultDuration = Duration(seconds: 3);
  static const _padding = EdgeInsets.symmetric(horizontal: 20, vertical: 10);

  static void error(String message, {Duration? duration}) => _showToast(
        message,
        icon: const Icon(Icons.error, color: AppColors.light100),
        backgroundColor: AppColors.error900,
        duration: duration,
      );

  static void success(String message, {Duration? duration}) => _showToast(
        message,
        icon: const Icon(Icons.check_circle, color: AppColors.light100),
        backgroundColor: AppColors.success900,
        duration: duration,
      );

  static void warning(String message, {Duration? duration}) => _showToast(
        message,
        icon: const Icon(Icons.warning, color: AppColors.light100),
        backgroundColor: AppColors.warning900,
        duration: duration,
      );

  static void show(
    String message, {
    Duration? duration,
    Widget? icon,
    Color? backgroundColor,
    Color? textColor,
  }) =>
      _showToast(
        message,
        icon: icon,
        backgroundColor: backgroundColor ?? AppColors.primary900,
        duration: duration,
        textColor: textColor,
      );

  static void _showToast(
    String message, {
    Widget? icon,
    required Color backgroundColor,
    Duration? duration,
    Color? textColor,
  }) {
    _scaffoldKey.currentState?.showSnackBar(
      SnackBar(
        content: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (icon != null) ...[
              icon,
              const SizedBox(width: 10),
            ],
            Flexible(
              child: Text(
                message,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyle.textMdMedium.copyWith(
                  color: textColor ?? AppColors.light100,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: backgroundColor,
        duration: duration ?? _defaultDuration,
        dismissDirection: DismissDirection.startToEnd,
        padding: _padding,
        elevation: 0,
      ),
    );
  }
}
