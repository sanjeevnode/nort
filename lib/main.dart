import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:nort/app.dart';
import 'package:nort/data/local/database.dart';
import 'package:nort/data/local/persistent_storage.dart';
import 'package:nort/data/repository/user_repository_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import 'domain/cubit/app_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(
    widgetsBinding: WidgetsFlutterBinding.ensureInitialized(),
  );

  final SharedPreferences sp = await SharedPreferences.getInstance();
  final Database db = await AppDatabase().database;
  final PersistentStorage localStorage =
      PersistentStorage(sharedPreferences: sp);

  final UserRepositoryImpl userRepository = UserRepositoryImpl(
    db: db,
    localStorage: localStorage,
  );

  final appCubit = AppCubit(userRepository: userRepository);

  await appCubit.init();

  FlutterNativeSplash.remove();

  runApp(
    App(
      appCubit: appCubit,
    ),
  );
}
