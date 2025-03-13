import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nort/core/core.dart';
import 'package:nort/domain/domain.dart';
import 'package:nort/ui/ui.dart';

class NoteListPage extends StatefulWidget {
  const NoteListPage({super.key});

  @override
  State<NoteListPage> createState() => _NoteListPageState();
}

class _NoteListPageState extends State<NoteListPage> {
  Future<void> _showBottomSheet() async {
    final pass =
        await Navigator.pushNamed(context, AppRouteNames.enterPassword);
    log('password: get $pass');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.light100,
      appBar: CustomAppBar(
        title: 'My Notes',
        prefix: SvgPicture.asset(
          'assets/icons/mynote.svg',
          width: 24,
          height: 24,
          colorFilter: const ColorFilter.mode(
            AppColors.dark900,
            BlendMode.srcIn,
          ),
        ),
      ),
      body: ListView(
        children: [
          NoteItem(
            title: 'Gmail',
            lastUpdated: '2025-01-15 12:00:00',
            onTap: _showBottomSheet,
          ),
          const NoteItem(
            title: 'Facebook',
            lastUpdated: '2025-01-15 12:00:00',
          ),
        ],
      ),
    );
  }

  Widget _emptyScreen() {
    return Container(
      color: AppColors.dark100.withOpacity(.1),
      padding: const EdgeInsets.all(20),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  context.read<AppCubit>().setNav(NavType.addNotes);
                },
                child: Image.asset(
                  'assets/images/empty.png',
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Add a note to get started.',
                textAlign: TextAlign.center,
                style: AppTextStyle.textXlRegular.copyWith(
                  color: AppColors.dark100,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
