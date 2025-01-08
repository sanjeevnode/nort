import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:nort/app.dart';
import 'package:nort/data/database.dart';
import 'package:nort/repository/user_repository.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(
      widgetsBinding: WidgetsFlutterBinding.ensureInitialized());
  FlutterNativeSplash.remove();

  final Database db = await AppDatabase().database;
  final UserRepository userRepository = UserRepository(db: db);

  runApp(
    App(
      userRepository: userRepository,
      db: db,
    ),
  );
}
