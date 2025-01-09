import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nort/core/theme/app_colors.dart';
import 'package:nort/core/theme/app_text_style.dart';
import 'package:nort/domain/cubit/app_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.light100,
      body: Center(
        child: BlocBuilder<AppCubit, AppState>(builder: (context, state) {
          return Column(
            children: [
              Text(
                'User: ${state.user?.username}',
                style: AppTextStyle.displayH1,
              ),
            ],
          );
        }),
      ),
    );
  }
}
