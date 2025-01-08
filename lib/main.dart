import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:nort/app.dart';
import 'package:nort/data/local/database.dart';
import 'package:nort/data/repository/user_repository_impl.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(
      widgetsBinding: WidgetsFlutterBinding.ensureInitialized());
  FlutterNativeSplash.remove();

  final Database db = await AppDatabase().database;
  final UserRepositoryImpl userRepository = UserRepositoryImpl(db: db);

  runApp(
    App(
      userRepository: userRepository,
      db: db,
    ),
  );
}
