import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nort/core/core.dart';
import 'package:nort/domain/domain.dart';
import 'package:nort/ui/ui.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final _pinController = TextEditingController();
  final _confirmPinController = TextEditingController();
  final ValueNotifier<ButtonState> _buttonStateNotifier =
      ValueNotifier<ButtonState>(ButtonState.disable);

  void _validateOnTextChange() {
    if (_pinController.text.isNotEmpty &&
        _confirmPinController.text.isNotEmpty &&
        _pinController.text.length == 6 &&
        _confirmPinController.text.length == 6) {
      _buttonStateNotifier.value = ButtonState.enable;
    } else {
      _buttonStateNotifier.value = ButtonState.disable;
    }
  }

  @override
  void initState() {
    _pinController.addListener(_validateOnTextChange);
    _confirmPinController.addListener(_validateOnTextChange);
    super.initState();
  }

  @override
  void dispose() {
    _pinController.dispose();
    _confirmPinController.dispose();
    super.dispose();
  }

  Future<void> _handleSave() async {
    final String pin = _pinController.text.trim();
    final String confirmPin = _confirmPinController.text.trim();
    if (pin != confirmPin || pin.length != 6 || confirmPin.length != 6) {
      Toast.warning("PIN does not match");
      return;
    }
    await context.read<AppCubit>().setMasterPin(pin: pin);
    _afterSave();
  }

  void _afterSave() {
    Navigator.pushReplacementNamed(context, AppRouteNames.home);
  }

  @override
  Widget build(BuildContext context) {
    final sc = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: ScrollWrapper(
          height: sc.height,
          children: [
            SizedBox(height: sc.height * 0.05),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/icons/logo.svg',
                  width: 44,
                  height: 44,
                ),
                const SizedBox(width: 8),
                Text(
                  "Nort",
                  style: AppTextStyle.displayH3.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            SizedBox(height: sc.height * 0.08),
            Text(
              "Set Your Master PIN",
              style: AppTextStyle.text3xlBold,
            ),
            const SizedBox(height: 10),
            Text(
              "This PIN will be used to encrypt your data and ensure only you can access it securely.",
              style: AppTextStyle.textMdMedium.copyWith(
                color: AppColors.dark500,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              " PIN",
              style: AppTextStyle.textMdMedium.copyWith(
                color: AppColors.dark500,
              ),
            ),
            const SizedBox(height: 8),
            CustomTextField(
              controller: _pinController,
              hintText: "eg. 123456",
              isPassword: true,
              keyboardType: TextInputType.number,
              maxLength: 6,
            ),
            const SizedBox(height: 16),
            Text(
              " Confirm PIN",
              style: AppTextStyle.textMdMedium.copyWith(
                color: AppColors.dark500,
              ),
            ),
            const SizedBox(height: 8),
            CustomTextField(
              controller: _confirmPinController,
              hintText: "eg. 123456",
              isPassword: true,
              keyboardType: TextInputType.number,
              maxLength: 6,
            ),
            const SizedBox(height: 8),
            Text(
              "Note* : The PIN should be 6 digits long.",
              style: AppTextStyle.textMdMedium.copyWith(
                color: AppColors.warning900,
              ),
            ),
            const SizedBox(height: 20),
            BlocBuilder<AppCubit, AppState>(builder: (context, state) {
              return SizedBox(
                width: double.infinity,
                child: ValueListenableBuilder<ButtonState>(
                  valueListenable: _buttonStateNotifier,
                  builder: (context, buttonState, child) {
                    return PrimaryButton(
                      label: "Save",
                      buttonState: state.pinStatus == Status.loading
                          ? ButtonState.loading
                          : buttonState,
                      onPressed: _handleSave,
                    );
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
