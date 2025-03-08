import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nort/core/constants/button_state.dart';
import 'package:nort/core/constants/status.dart';
import 'package:nort/core/theme/app_colors.dart';
import 'package:nort/domain/cubit/app_cubit.dart';
import 'package:nort/ui/routes/app_route_name.dart';
import 'package:nort/ui/widgets/app_button.dart';
import 'package:nort/ui/widgets/custom_app_bar.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Future<void> _logout() async {
    await context.read<AppCubit>().logout();
    _afterLogout();
  }

  void _afterLogout() {
    final state = context.read<AppCubit>().state;
    if (state.logoutStatus == Status.success) {
      context.read<AppCubit>().reset();
      Navigator.of(context).pushReplacementNamed(AppRouteNames.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    final sc = MediaQuery.of(context).size;
    return BlocBuilder<AppCubit, AppState>(builder: (context, state) {
      return Scaffold(
        backgroundColor: AppColors.light100,
        appBar: CustomAppBar(
          title: 'Profile',
          prefix: SvgPicture.asset(
            'assets/icons/profile.svg',
            width: 24,
            height: 24,
            colorFilter: const ColorFilter.mode(
              AppColors.dark900,
              BlendMode.srcIn,
            ),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  width: sc.width,
                  child: PrimaryButton(
                    label: 'Logout',
                    buttonState: state.logoutStatus == Status.loading
                        ? ButtonState.loading
                        : ButtonState.enable,
                    onPressed: _logout,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
