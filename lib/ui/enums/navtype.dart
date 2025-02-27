import 'package:flutter/material.dart';
import 'package:nort/ui/view/home/add_notes.dart';
import 'package:nort/ui/view/home/profile.dart';
import 'package:nort/ui/view/home/settings.dart';
import 'package:nort/ui/widgets/note_list_page.dart';

enum Navtype {
  home,
  addNotes,
  settings,
  profile,
}

extension NavtypeExtension on Navtype {
  String get title {
    switch (this) {
      case Navtype.home:
        return 'Home';
      case Navtype.addNotes:
        return 'Add Notes';
      case Navtype.settings:
        return 'Settings';
      case Navtype.profile:
        return 'Profile';
    }
  }

  Widget get screen {
    switch (this) {
      case Navtype.home:
        return const NoteListPage();
      case Navtype.addNotes:
        return const AddNotes();
      case Navtype.settings:
        return const Settings();
      case Navtype.profile:
        return const Profile();
    }
  }
}
