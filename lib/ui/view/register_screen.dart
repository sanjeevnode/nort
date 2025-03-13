import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nort/core/core.dart';
import 'package:nort/domain/domain.dart';
import 'package:nort/ui/ui.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final ValueNotifier<ButtonState> _buttonStateNotifier =
      ValueNotifier<ButtonState>(ButtonState.disable);

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
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _userNameController.text.isNotEmpty) {
      _buttonStateNotifier.value = ButtonState.enable;
    } else {
      _buttonStateNotifier.value = ButtonState.disable;
    }
  }

  Future<void> _register() async {
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();
    final String userName = _userNameController.text.trim();

    await context.read<AppCubit>().register(
          username: userName,
          email: email,
          password: password,
        );
    _afterRegister();
  }

  void _afterRegister() {
    final state = context.read<AppCubit>().state;
    if (state.registerStatus == Status.success) {
      Toast.success(
        "Registration done, please login",
        duration: const Duration(seconds: 2),
      );
      Navigator.of(context).pushReplacementNamed(AppRouteNames.login);
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
                  "Create an account",
                  style: AppTextStyle.text3xlBold,
                ),
                const SizedBox(height: 24),
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
                BlocBuilder<AppCubit, AppState>(builder: (context, state) {
                  return SizedBox(
                    width: double.infinity,
                    child: ValueListenableBuilder<ButtonState>(
                      valueListenable: _buttonStateNotifier,
                      builder: (context, buttonState, child) {
                        return PrimaryButton(
                            label: "Register",
                            buttonState: state.registerStatus == Status.loading
                                ? ButtonState.loading
                                : buttonState,
                            onPressed: _register);
                      },
                    ),
                  );
                }),
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
                        Navigator.of(context)
                            .pushReplacementNamed(AppRouteNames.login);
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
