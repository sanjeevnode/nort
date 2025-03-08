import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nort/core/constants/button_state.dart';
import 'package:nort/core/constants/status.dart';
import 'package:nort/core/theme/app_colors.dart';
import 'package:nort/core/theme/app_text_style.dart';
import 'package:nort/domain/cubit/app_cubit.dart';
import 'package:nort/ui/routes/app_route_name.dart';
import 'package:nort/ui/widgets/app_button.dart';
import 'package:nort/ui/widgets/app_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final ValueNotifier<ButtonState> _buttonStateNotifier = ValueNotifier<ButtonState>(ButtonState.disable);


  @override
  void initState() {
    _emailController.addListener(_validateOnTextChange);
    _passwordController.addListener(_validateOnTextChange);
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _validateOnTextChange() {
    if (_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
      _buttonStateNotifier.value = ButtonState.enable;
    } else {
      _buttonStateNotifier.value = ButtonState.disable;
    }
  }

  Future<void> _login() async {
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();

    await context.read<AppCubit>().login(
      email: email,
      password: password,
    );
    _afterLogin();
  }

  void _afterLogin() {
    final state = context.read<AppCubit>().state;
    if(state.loginStatus == Status.success) {
      if(state.user!.masterPassword == null) {
        Navigator.of(context).pushReplacementNamed(AppRouteNames.onboarding);
      } else {
        Navigator.of(context).pushReplacementNamed(AppRouteNames.home);
      }
    }
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
              width: sc.width,
              height: sc.height * 0.5,
              fit: BoxFit.cover,
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
                  BlocBuilder<AppCubit,AppState>(
                    builder: (context,state) {
                      return SizedBox(
                        width: double.infinity,
                        child: ValueListenableBuilder<ButtonState>(
                          valueListenable: _buttonStateNotifier,
                          builder: (context, buttonState, child) {
                            return PrimaryButton(
                              label: "Login",
                              buttonState: state.loginStatus == Status.loading ? ButtonState.loading : buttonState,
                              onPressed: _login,
                            );
                          },
                        ),
                      );
                    }
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account ?",
                        style: AppTextStyle.textMdMedium.copyWith(
                          color: AppColors.dark500,
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .pushReplacementNamed(AppRouteNames.register);
                        },
                        child: Text(
                          "Register",
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
