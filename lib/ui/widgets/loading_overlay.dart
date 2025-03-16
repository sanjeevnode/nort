import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nort/core/core.dart';
import 'package:nort/domain/domain.dart';

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(0.3),
        body: const Center(
          child: LoadingWidget(),
        ),
      ),
    );
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
    this.size = 24,
    this.color,
    this.strokeWidth = 2,
  });

  final double size;
  final Color? color;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(color ?? AppColors.dark900),
        strokeWidth: strokeWidth,
      ),
    );
  }
}

class LoadingWrapper extends StatelessWidget {
  const LoadingWrapper({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(builder: (context, state) {
      return Stack(
        children: [
          child,
          if (state.showLoadingOverlay) const LoadingOverlay(),
        ],
      );
    });
  }
}
