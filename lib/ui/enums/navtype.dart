import 'package:flutter/material.dart';
import 'package:nort/ui/view/home/add_notes.dart';
import 'package:nort/ui/view/home/note_list_page.dart';
import 'package:nort/ui/view/home/profile.dart';
import 'package:nort/ui/view/home/settings.dart';

enum NavType {
  home,
  addNotes,
  settings,
  profile,
}

extension NavTypeExtension on NavType {
  String get title {
    switch (this) {
      case NavType.home:
        return 'Home';
      case NavType.addNotes:
        return 'Add Notes';
      case NavType.settings:
        return 'Settings';
      case NavType.profile:
        return 'Profile';
    }
  }

  Widget get screen {
    switch (this) {
      case NavType.home:
        return const NoteListPage();
      case NavType.addNotes:
        return const AddNotes();
      case NavType.settings:
        return const Settings();
      case NavType.profile:
        return const Profile();
    }
  }
}
