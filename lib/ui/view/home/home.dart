import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nort/core/theme/app_colors.dart';
import 'package:nort/domain/cubit/app_cubit.dart';
import 'package:nort/ui/enums/navtype.dart';
import 'package:nort/ui/widgets/navbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.light100,
          bottomNavigationBar: const Navbar(),
          body: state.navType.screen,
        );
      },
    );
  }
}
