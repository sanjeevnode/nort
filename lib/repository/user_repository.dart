import 'dart:developer';

import 'package:nort/model/user_model.dart';
import 'package:nort/utils/hash.dart';
import 'package:sqflite/sqflite.dart';

class UserRepository {
  UserRepository({
    required Database db,
  }) : _db = db;

  final Database _db;

  Future<int> addUser(User user) async {
    try {
      log('Adding user: $user');
      final hashPass = Hash.generate(user.password);
      log('Hashed password: $hashPass');
      final id = await _db.insert(
        'users',
        {
          'username': user.username,
          'email': user.email,
          'password': hashPass,
        },
      );
      log('User added with id: $id');
      return id;
    } catch (e) {
      log('Error adding user: $e');
      return -1;
    }
  }

  Future<List<User>> getAllUsers() async {
    try {
      final List<Map<String, dynamic>> users = await _db.query('users');
      return users
          .map((Map<String, dynamic> user) => User.fromJson(user))
          .toList();
    } catch (e) {
      log('Error fetching users: $e');
      return [];
    }
  }
}
