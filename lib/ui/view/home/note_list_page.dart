// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nort/core/core.dart';
import 'package:nort/data/data.dart';
import 'package:nort/domain/domain.dart';
import 'package:nort/ui/ui.dart';

class NoteListPage extends StatefulWidget {
  const NoteListPage({super.key});

  @override
  State<NoteListPage> createState() => _NoteListPageState();
}

class _NoteListPageState extends State<NoteListPage> {
  Future<void> _onNoteTap(Note note) async {
    final pass =
        await Navigator.pushNamed(context, AppRouteNames.enterPassword);
    if (pass == null) {
      return;
    }
    final decNote = await context.read<AppCubit>().getDcryptedNote(
          id: note.id!,
          pin: pass.toString(),
        );
    if (decNote != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditNotePage(note: decNote),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final sc = MediaQuery.of(context).size;
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
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
          body: SizedBox(
            height: sc.height,
            width: sc.width,
            child: state.notes.isEmpty
                ? _emptyScreen()
                : ListView.builder(
                    itemCount: state.notes.length,
                    itemBuilder: (context, index) {
                      final note = state.notes.reversed.toList()[index];
                      final updateAt = DateTime.parse(note.updatedAt!);
                      return NoteItem(
                        title: note.title,
                        lastUpdated: AppUtils.formatDate(updateAt.toLocal()),
                        onTap: () => _onNoteTap(note),
                      );
                    },
                  ),
          ),
        );
      },
    );
  }

  Widget _emptyScreen() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              context.read<AppCubit>().setNav(NavType.addNotes);
            },
            child: SvgPicture.asset(
              'assets/icons/add.svg',
              width: 24,
              height: 24,
              colorFilter: const ColorFilter.mode(
                AppColors.dark100,
                BlendMode.srcIn,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            'Add a Note',
            textAlign: TextAlign.center,
            style: AppTextStyle.textXlRegular.copyWith(
              color: AppColors.dark100,
            ),
          ),
        ],
      ),
    );
  }
}
