import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nort/core/theme/app_colors.dart';
import 'package:nort/domain/cubit/app_cubit.dart';
import 'package:nort/ui/enums/navtype.dart';
import 'package:nort/ui/widgets/nav_item.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(builder: (context, state) {
      return Material(
        elevation: 10,
        child: Container(
          decoration: const BoxDecoration(
            color: AppColors.light100,
          ),
          child: Row(
            children: [
              Expanded(
                child: NavItem(
                  iconPath: 'assets/icons/home.svg',
                  isActive: state.navType == NavType.home,
                  onPressed: () {
                    context.read<AppCubit>().setNav(NavType.home);
                  },
                ),
              ),
              Expanded(
                child: NavItem(
                  iconPath: 'assets/icons/add.svg',
                  isActive: state.navType == NavType.addNotes,
                  onPressed: () {
                    context.read<AppCubit>().setNav(NavType.addNotes);
                  },
                ),
              ),
              Expanded(
                child: NavItem(
                  iconPath: 'assets/icons/settings.svg',
                  isActive: state.navType == NavType.settings,
                  onPressed: () {
                    context.read<AppCubit>().setNav(NavType.settings);
                  },
                ),
              ),
              Expanded(
                child: NavItem(
                  iconPath: 'assets/icons/profile.svg',
                  isActive: state.navType == NavType.profile,
                  onPressed: () {
                    context.read<AppCubit>().setNav(NavType.profile);
                  },
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
