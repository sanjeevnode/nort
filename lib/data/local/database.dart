import 'dart:developer';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AppDatabase {
  static final AppDatabase _instance = AppDatabase._internal();
  factory AppDatabase() => _instance;
  AppDatabase._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'nort.db');
    await _deleteDB(path);
    log('Database path : $path');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // Create users table
        await db.execute('''
          CREATE TABLE users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            username TEXT NOT NULL UNIQUE,
            email TEXT NOT NULL UNIQUE,
            password TEXT NOT NULL,
            masterPassword TEXT, 
            salt TEXT NOT NULL,  
            isVerified INTEGER NOT NULL DEFAULT 0,
            createdAt TEXT DEFAULT (datetime('now') || 'Z'),
            updatedAt TEXT DEFAULT (datetime('now') || 'Z')
          )
        ''');
        // Create Note table
        await db.execute('''
          CREATE TABLE notes (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            userId INTEGER NOT NULL,
            title VARCHAR(100) NOT NULL,
            content TEXT NOT NULL,
            salt TEXT NOT NULL,
            createdAt TEXT DEFAULT (datetime('now') || 'Z'),
            updatedAt TEXT DEFAULT (datetime('now') || 'Z')
          )
        ''');
      },
    );
  }

  Future<void> _deleteDB(String path) async {
    await deleteDatabase(path);
    log('Existing Database Deleted');
  }
}
