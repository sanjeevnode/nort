import 'package:flutter/material.dart';
import 'package:nort/constants/button_state.dart';
import 'package:nort/theme/app_colors.dart';
import 'package:nort/theme/app_text_style.dart';
import 'package:nort/widgets/custom_primary_button.dart';
import 'package:nort/widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sc = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.light100,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              "assets/images/auth_screen_banner.png",
            ),
            // const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome!",
                    style: AppTextStyle.text3xlBold,
                  ),
                  const SizedBox(height: 24),
                  CustomTextField(
                    controller: _emailController,
                    hintText: "Email Address",
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _passwordController,
                    hintText: "Password",
                    isPassword: true,
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {
                      debugPrint("Forgot Password");
                    },
                    child: Text(
                      "Forgot Password ?",
                      style: AppTextStyle.textLgMedium.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: CustomPrimaryButton(
                      label: "Login",
                      onPressed: () {
                        debugPrint("Login");
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account ?",
                        style: AppTextStyle.textMdMedium,
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          debugPrint("Sign Up");
                        },
                        child: Text(
                          "Register now",
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
          ],
        ),
      ),
    );
  }
}
