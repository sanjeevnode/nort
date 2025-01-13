import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nort/core/constants/button_state.dart';
import 'package:nort/core/constants/status.dart';
import 'package:nort/core/theme/app_colors.dart';
import 'package:nort/core/theme/app_text_style.dart';
import 'package:nort/core/toast.dart';
import 'package:nort/domain/cubit/app_cubit.dart';
import 'package:nort/ui/widgets/custom_primary_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> _logout() async {
    await context.read<AppCubit>().logout();
    _afterLogout();
  }

  void _afterLogout() {
    final state = context.read<AppCubit>().state;
    if (state.logoutStatus == Status.success) {
      context.read<AppCubit>().reset();
      Navigator.of(context).pushReplacementNamed('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    final sc = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.light100,
      body: BlocBuilder<AppCubit, AppState>(builder: (context, state) {
        return Container(
          width: sc.width,
          height: sc.height,
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'User: ${state.user?.username}',
                style: AppTextStyle.displayH1,
              ),
              const SizedBox(height: 20.0),
              SizedBox(
                width: sc.width,
                child: CustomPrimaryButton(
                  label: 'Logout',
                  buttonState: state.logoutStatus == Status.loading
                      ? ButtonState.loading
                      : ButtonState.enable,
                  onPressed: _logout,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
