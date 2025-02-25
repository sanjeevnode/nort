import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nort/core/theme/app_colors.dart';
import 'package:nort/core/theme/app_text_style.dart';

class EnterMasterPassword extends StatefulWidget {
  const EnterMasterPassword({super.key});

  @override
  State<EnterMasterPassword> createState() => _EnterMasterPasswordState();
}

class _EnterMasterPasswordState extends State<EnterMasterPassword> {
  final List<String> _password = List.filled(6, '');

  @override
  Widget build(BuildContext context) {
    final sc = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.dark900,
                    size: 16,
                  ),
                ),
                const SizedBox(width: 8),
                SvgPicture.asset(
                  'assets/icons/logo.svg',
                  width: 20,
                  height: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Nort',
                  maxLines: 1,
                  style: AppTextStyle.textLgMedium.copyWith(
                    color: AppColors.dark900,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        height: sc.height,
        width: sc.width,
        color: AppColors.light100,
        child: Column(
          children: [
            SizedBox(height: sc.height * 0.1),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'ENTER 6-DIGIT MASTER PIN',
                  style: AppTextStyle.textLgRegular.copyWith(
                    color: AppColors.dark900,
                  ),
                ),
              ],
            ),
            SizedBox(height: sc.height * 0.05),
            Builder(builder: (context) {
              final width = sc.width - 40;
              final itemSize = (width - 36) / 6;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 0; i < _password.length; i++) ...[
                      Builder(builder: (context) {
                        final p = _password[i];
                        return Container(
                          width: itemSize,
                          height: itemSize,
                          decoration: BoxDecoration(),
                        );
                      }),
                      if (i != 5) const SizedBox(width: 6),
                    ]
                  ],
                ),
              );
            }),
            const Spacer(),
            Builder(builder: (context) {
              final height = sc.height * .4;
              return Container(
                width: sc.width,
                height: height,
                color: Colors.pink,
              );
            }),
          ],
        ),
      ),
    );
  }
}
