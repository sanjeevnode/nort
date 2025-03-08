import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTextStyle {
  const AppTextStyle._();

  static const _baseTextStyle = TextStyle(
    fontWeight: FontWeight.w400,
    fontFamily: 'Montserrat',
    decoration: TextDecoration.none,
    textBaseline: TextBaseline.alphabetic,
    color: AppColors.dark900,
  );

  static final displayH1 = _baseTextStyle.copyWith(
    fontSize: 44,
    fontWeight: FontWeight.bold,
    height: 56 / 44,
  );

  static final displayH2 = _baseTextStyle.copyWith(
    fontSize: 36,
    height: 48 / 36,
    fontWeight: FontWeight.bold,
  );
  static final displayH3 = _baseTextStyle.copyWith(
    fontSize: 28,
    height: 36 / 28,
    fontWeight: FontWeight.bold,
  );

  static final text3xlRegular = _baseTextStyle.copyWith(
    fontSize: 24,
    height: 28 / 24,
    fontWeight: FontWeight.w400,
  );
  static final text3xlMedium = _baseTextStyle.copyWith(
    fontSize: 24,
    height: 28 / 24,
    fontWeight: FontWeight.w500,
  );
  static final text3xlSemibold = _baseTextStyle.copyWith(
    fontSize: 24,
    height: 28 / 24,
    fontWeight: FontWeight.w600,
  );
  static final text3xlBold = _baseTextStyle.copyWith(
    fontSize: 24,
    height: 28 / 24,
    fontWeight: FontWeight.bold,
  );

  static final text2xlRegular = _baseTextStyle.copyWith(
    fontSize: 20,
    height: 28 / 20,
    fontWeight: FontWeight.w400,
  );
  static final text2xlMedium = _baseTextStyle.copyWith(
    fontSize: 20,
    height: 28 / 20,
    fontWeight: FontWeight.w500,
  );
  static final text2xlSemibold = _baseTextStyle.copyWith(
    fontSize: 20,
    height: 28 / 20,
    fontWeight: FontWeight.w600,
  );
  static final text2xlBold = _baseTextStyle.copyWith(
    fontSize: 20,
    height: 28 / 20,
    fontWeight: FontWeight.bold,
  );

  static final textXlRegular = _baseTextStyle.copyWith(
    fontSize: 18,
    height: 26 / 18,
    fontWeight: FontWeight.w400,
  );
  static final textXlMedium = _baseTextStyle.copyWith(
    fontSize: 18,
    height: 26 / 18,
    fontWeight: FontWeight.w500,
  );
  static final textXlSemibold = _baseTextStyle.copyWith(
    fontSize: 18,
    height: 26 / 18,
    fontWeight: FontWeight.w600,
  );
  static final textXlBold = _baseTextStyle.copyWith(
    fontSize: 18,
    height: 26 / 18,
    fontWeight: FontWeight.bold,
  );

  static final textLgRegular = _baseTextStyle.copyWith(
    fontSize: 16,
    height: 24 / 16,
    fontWeight: FontWeight.w400,
  );
  static final textLgMedium = _baseTextStyle.copyWith(
    fontSize: 16,
    height: 24 / 16,
    fontWeight: FontWeight.w500,
  );
  static final textLgSemibold = _baseTextStyle.copyWith(
    fontSize: 16,
    height: 24 / 16,
    fontWeight: FontWeight.w600,
  );
  static final textLgBold = _baseTextStyle.copyWith(
    fontSize: 16,
    height: 24 / 16,
    fontWeight: FontWeight.bold,
  );

  static final textMdRegular = _baseTextStyle.copyWith(
    fontSize: 14,
    height: 20 / 14,
    fontWeight: FontWeight.w400,
  );
  static final textMdMedium = _baseTextStyle.copyWith(
    fontSize: 14,
    height: 20 / 14,
    fontWeight: FontWeight.w500,
  );
  static final textMdSemibold = _baseTextStyle.copyWith(
    fontSize: 14,
    height: 20 / 14,
    fontWeight: FontWeight.w600,
  );
  static final textMdBold = _baseTextStyle.copyWith(
    fontSize: 14,
    height: 20 / 14,
    fontWeight: FontWeight.bold,
  );

  static final textSmRegular = _baseTextStyle.copyWith(
    fontSize: 12,
    height: 18 / 12,
    fontWeight: FontWeight.w400,
  );
  static final textSmMedium = _baseTextStyle.copyWith(
    fontSize: 12,
    height: 18 / 12,
    fontWeight: FontWeight.w500,
  );
  static final textSmSemibold = _baseTextStyle.copyWith(
    fontSize: 12,
    height: 18 / 12,
    fontWeight: FontWeight.w600,
  );
  static final textSmBold = _baseTextStyle.copyWith(
    fontSize: 12,
    height: 18 / 12,
    fontWeight: FontWeight.bold,
  );

  static final textXsRegular = _baseTextStyle.copyWith(
    fontSize: 11,
    height: 16 / 11,
    fontWeight: FontWeight.w400,
  );
  static final textXsMedium = _baseTextStyle.copyWith(
    fontSize: 11,
    height: 16 / 11,
    fontWeight: FontWeight.w500,
  );
  static final textXsSemibold = _baseTextStyle.copyWith(
    fontSize: 11,
    height: 16 / 11,
    fontWeight: FontWeight.w600,
  );
  static final textXsBold = _baseTextStyle.copyWith(
    fontSize: 11,
    height: 16 / 11,
    fontWeight: FontWeight.bold,
  );
}
