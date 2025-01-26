import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nort/core/theme/app_colors.dart';
import 'package:nort/domain/cubit/app_cubit.dart';
import 'package:nort/ui/widgets/nav_item.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit,AppState>(
      builder: (context,state) {
        return Material(
          elevation: 10,
          child: Container(
            decoration: const BoxDecoration(
              color: AppColors.light100,
            ),
            child:  Row(
              children: [
                Expanded(
                  child: NavItem(
                    iconPath: 'assets/icons/home.svg',
                    isActive: state.navIndex == 0,
                    onPressed: () {
                      context.read<AppCubit>().setNavIndex(0);
                    },
                  ),
                ),
                Expanded(
                  child: NavItem(
                    iconPath: 'assets/icons/add.svg',
                    isActive: state.navIndex == 1,
                    onPressed: () {
                      context.read<AppCubit>().setNavIndex(1);
                    },
                  ),
                ),
                Expanded(
                  child: NavItem(
                    iconPath: 'assets/icons/settings.svg',
                    isActive: state.navIndex == 2,
                    onPressed: () {
                      context.read<AppCubit>().setNavIndex(2);
                    },
                  ),
                ),
                Expanded(
                  child: NavItem(
                    iconPath: 'assets/icons/profile.svg',
                    isActive: state.navIndex == 3,
                    onPressed: () {
                      context.read<AppCubit>().setNavIndex(3);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}
