import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:nort/core/core.dart';

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(0.3),
        body: const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(AppColors.dark900),
            strokeWidth: 2,
          ),
        ),
      ),
    );
  }
}
