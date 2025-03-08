import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nort/core/theme/app_colors.dart';
import 'package:nort/ui/widgets/custom_app_bar.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.light100,
      appBar: CustomAppBar(
        title: 'Settings',
        prefix: SvgPicture.asset(
          'assets/icons/settings.svg',
          width: 24,
          height: 24,
          colorFilter: const ColorFilter.mode(
            AppColors.dark900,
            BlendMode.srcIn,
          ),
        ),
      ),
      body: const Column(
        children: [Text('Settings')],
      ),
    );
  }
}
