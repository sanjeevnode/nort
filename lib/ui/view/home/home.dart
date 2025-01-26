import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nort/core/theme/app_colors.dart';
import 'package:nort/core/theme/app_text_style.dart';
import 'package:nort/domain/cubit/app_cubit.dart';
import 'package:nort/ui/view/home/add_notes.dart';
import 'package:nort/ui/view/home/note_list_page.dart';
import 'package:nort/ui/view/home/profile.dart';
import 'package:nort/ui/view/home/settings.dart';
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
          appBar: AppBar(
            title: Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/logo.svg',
                  width: 20,
                  height: 20,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  _getTitle(state.navIndex),
                  style: AppTextStyle.textLgMedium,
                ),
              ],
            ),
            backgroundColor: AppColors.light100,
            elevation: 0,
            scrolledUnderElevation: 0,
          ),
          body: _getScreen(state.navIndex),
        );
      },
    );
  }

  Widget _getScreen(int index) {
    switch (index) {
      case 0:
        return const NoteListPage();
      case 1:
        return const AddNotes();
      case 2:
        return const Settings();
      case 3:
        return const Profile();
      default:
        return const NoteListPage();
    }
  }

  String _getTitle(int index) {
    switch (index) {
      case 0:
        return 'My Notes';
      case 1:
        return 'Add Notes';
      case 2:
        return 'Settings';
      case 3:
        return 'Profile';
      default:
        return 'Home';
    }
  }
}
