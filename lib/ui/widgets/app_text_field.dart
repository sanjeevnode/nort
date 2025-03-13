import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nort/core/core.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    this.hintText,
    this.labelText,
    this.errorText,
    this.suffix,
    this.prefix,
    this.onChanged,
    this.maxLength,
    this.validate = false,
    this.isPassword = false,
    this.readOnly = false,
    this.borderRadius = 15,
    this.keyboardType = TextInputType.text,
    this.padding = const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 12,
    ),
  });

  final TextEditingController controller;
  final String? hintText;

  final String? labelText;

  final String? errorText;

  final bool isPassword;

  final double borderRadius;

  final EdgeInsets padding;

  final Widget? suffix;

  final Widget? prefix;

  final bool validate;

  final bool readOnly;

  final void Function(String)? onChanged;

  final TextInputType keyboardType;

  final int? maxLength;

  OutlineInputBorder get _border => OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: const BorderSide(
          color: AppColors.dark300,
        ),
      );

  OutlineInputBorder get _errorBorder => OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: const BorderSide(
          color: AppColors.error500,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: AppTextStyle.textLgMedium,
      cursorColor: AppColors.dark300,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: AppTextStyle.textLgRegular.copyWith(
          color: AppColors.dark100,
          backgroundColor: AppColors.light100,
        ),
        hintText: hintText,
        hintStyle: AppTextStyle.textLgRegular.copyWith(
          color: AppColors.dark100,
        ),
        isDense: true,
        border: _border,
        enabledBorder: _border,
        focusedBorder: _border,
        errorBorder: _errorBorder,
        focusedErrorBorder: _errorBorder,
        contentPadding: padding,
        suffix: suffix,
        prefix: prefix,
      ),
      maxLength: maxLength,
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      buildCounter: (
        BuildContext context, {
        required int currentLength,
        required int? maxLength,
        required bool isFocused,
      }) =>
          null,
      keyboardType: keyboardType,
      obscureText: isPassword,
      obscuringCharacter: "*",
      readOnly: readOnly,
      validator: (value) {
        if ((value == null || value.isEmpty) && validate) {
          return errorText ?? '${labelText ?? "This field "} is required.';
        }
        return null;
      },
      onChanged: onChanged,
    );
  }
}
