import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nort/core/theme/app_colors.dart';
import 'package:nort/core/theme/app_text_style.dart';
import 'package:nort/ui/widgets/custom_app_bar.dart';

class EnterMasterPassword extends StatefulWidget {
  const EnterMasterPassword({super.key});

  @override
  State<EnterMasterPassword> createState() => _EnterMasterPasswordState();
}

class _EnterMasterPasswordState extends State<EnterMasterPassword> {
  final List<String> _password = [];
  bool _error = false;

  void _handleSae() {
    if (_password.length != 6) {
      setState(() {
        _error = true;
      });
      return;
    }
    log('password: $_password');
    Navigator.of(context).pop(
      _password.join(''),
    );
  }

  @override
  Widget build(BuildContext context) {
    final sc = MediaQuery.of(context).size;
    log('password: $_password');
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Nort',
        prefix: SvgPicture.asset(
          'assets/icons/logo.svg',
          width: 24,
          height: 24,
        ),
        enableBack: true,
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
              final itemSize = (width - 60) / 6;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 0; i < 6; i++) ...[
                      Builder(builder: (context) {
                        final flag = i + 1 <= _password.length;
                        return Container(
                          width: itemSize,
                          height: itemSize,
                          decoration: flag
                              ? null
                              : BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: _error
                                          ? AppColors.error900
                                          : AppColors.dark100,
                                      width: 2,
                                    ),
                                  ),
                                ),
                          child: flag
                              ? const Center(
                                  child: Icon(
                                    Icons.circle,
                                    color: AppColors.dark900,
                                    size: 10,
                                  ),
                                )
                              : null,
                        );
                      }),
                      if (i != 5) const SizedBox(width: 10),
                    ]
                  ],
                ),
              );
            }),
            const Spacer(),
            Builder(builder: (context) {
              final height = sc.height * .4;
              final h = height / 4;
              final w = sc.width / 3;
              return Container(
                width: sc.width,
                height: height,
                color: AppColors.light300.withOpacity(.5),
                child: Wrap(
                  children: [
                    for (int i = 1; i <= 9; i++)
                      NumberContainer(
                        w: w,
                        h: h,
                        text: i.toString(),
                        onTap: () {
                          setState(() {
                            if (_password.length == 6) return;
                            _password.add(i.toString());
                          });
                        },
                      ),
                    Material(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            if (_password.isEmpty) return;
                            _password.removeLast();
                          });
                        },
                        child: SizedBox(
                          width: w,
                          height: h,
                          child: const Center(
                            child: Icon(
                              Icons.backspace_outlined,
                              color: Color.fromARGB(255, 0, 63, 146),
                            ),
                          ),
                        ),
                      ),
                    ),
                    NumberContainer(
                      w: w,
                      h: h,
                      text: '0',
                      onTap: () {
                        setState(() {
                          if (_password.length == 6) return;
                          _password.add('0');
                        });
                      },
                    ),
                    Material(
                      child: InkWell(
                        onTap: _handleSae,
                        child: SizedBox(
                          width: w,
                          height: h,
                          child: Center(
                            child: Icon(
                              Icons.check_circle_sharp,
                              color: const Color.fromARGB(255, 0, 63, 146),
                              size: (w + h) / 2 * .5,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class NumberContainer extends StatelessWidget {
  const NumberContainer({
    super.key,
    required this.w,
    required this.h,
    required this.text,
    this.onTap,
  });
  final double w;
  final double h;
  final String text;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          width: w,
          height: h,
          child: Center(
            child: Text(
              text,
              style: AppTextStyle.text2xlRegular.copyWith(
                color: const Color.fromARGB(255, 0, 63, 146),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
