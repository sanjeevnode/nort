import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nort/constants/button_state.dart';
import 'package:nort/theme/app_colors.dart';
import 'package:nort/theme/app_text_style.dart';
import 'package:nort/widgets/custom_primary_button.dart';
import 'package:nort/widgets/custom_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final ValueNotifier<ButtonState> _buttonStateNotifier = ValueNotifier<ButtonState>(ButtonState.disable);


  @override
  void initState() {
    _emailController.addListener(_validateOnTextChange);
    _passwordController.addListener(_validateOnTextChange);
    _userNameController.addListener(_validateOnTextChange);
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _userNameController.dispose();
    super.dispose();
  }

  void _validateOnTextChange() {
    if (_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty && _userNameController.text.isNotEmpty) {
      _buttonStateNotifier.value = ButtonState.enable;
    } else {
      _buttonStateNotifier.value = ButtonState.disable;
    }
  }

  @override
  Widget build(BuildContext context) {
    final sc = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.light100,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: sc.width,
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 SizedBox(height: sc.height * 0.015),
                Center(
                  child: SvgPicture.asset(
                    'assets/icons/logo.svg',
                    width: 55,
                    height: 55,
                  ),
                ),
                SizedBox(height: sc.height * 0.1),
                Text(
                  " Username",
                  style: AppTextStyle.textMdMedium.copyWith(
                    color: AppColors.dark500,
                  ),
                ),
                const SizedBox(height: 8),
                CustomTextField(
                  controller: _userNameController,
                  hintText: "username",
                ),
                const SizedBox(height: 16),
                Text(
                  " Email",
                  style: AppTextStyle.textMdMedium.copyWith(
                    color: AppColors.dark500,
                  ),
                ),
                const SizedBox(height: 8),
                CustomTextField(
                  controller: _emailController,
                  hintText: "example@example.com",
                ),
                const SizedBox(height: 16),
                Text(
                  " Password",
                  style: AppTextStyle.textMdMedium.copyWith(
                    color: AppColors.dark500,
                  ),
                ),
                const SizedBox(height: 8),
                CustomTextField(
                  controller: _passwordController,
                  hintText: "*******",
                  isPassword: true,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ValueListenableBuilder<ButtonState>(
                    valueListenable: _buttonStateNotifier,
                    builder: (context, buttonState, child) {
                      return CustomPrimaryButton(
                          label: "Register",
                          buttonState: buttonState,
                          onPressed:() {
                            debugPrint("Register");
                          }
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account ? ",
                      style: AppTextStyle.textMdMedium.copyWith(
                        color: AppColors.dark500,
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacementNamed("/login");
                      },
                      child: Text(
                        "Login",
                        style: AppTextStyle.textMdMedium.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
