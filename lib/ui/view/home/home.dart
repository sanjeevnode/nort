import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nort/core/core.dart';
import 'package:nort/domain/domain.dart';
import 'package:nort/ui/ui.dart';
import 'package:nort/ui/widgets/loading_overlay.dart';

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
        if (state.showLoadingOverlay) {
          FocusScope.of(context).unfocus();
        }
        return LoadingWrapper(
          child: Scaffold(
            backgroundColor: AppColors.light100,
            bottomNavigationBar: const Navbar(),
            body: state.navType.screen,
          ),
        );
      },
    );
  }
}
