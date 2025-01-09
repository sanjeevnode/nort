import 'dart:developer';

import 'package:nort/core/constants/app_constant.dart';
import 'package:nort/core/utils/hash.dart';
import 'package:nort/data/local/persistent_storage.dart';
import 'package:nort/data/model/user_model.dart';
import 'package:nort/domain/repository/user_repository.dart';
import 'package:sqflite/sqflite.dart';

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl({
    required Database db,
    required PersistentStorage localStorage,
  })  : _db = db,
        _localStorage = localStorage;

  final Database _db;
  final PersistentStorage _localStorage;

  @override
  Future<(String?, int?)> addUser({required User user}) async {
    try {
      final (_,existingUser) = await getUser(email: user.email);
      if (existingUser != null) {
        return ('User already exists', null);
      }
      final hashPass = Hash.generate(user.password);
      final id = await _db.insert(
        'users',
        {
          'username': user.username,
          'email': user.email,
          'password': hashPass,
        },
      );
      return (null, id);
    } catch (e) {
      log('Error adding user: $e');
      return (e.toString(), null);
    }
  }

  @override
  Future<(String?, List<User>?)> getAllUsers() async {
    try {
      final List<Map<String, dynamic>> users = await _db.query('users');
      final u = users
          .map((Map<String, dynamic> user) => User.fromJson(user))
          .toList();
      return (null, u);
    } catch (e) {
      log('Error fetching users: $e');
      return (e.toString(), null);
    }
  }

  @override
  Future<(String?, int?)> checkLoggedInUser() async {
    try {
      final id = await _localStorage.read(key: AppConstant.localUserId);
      if (id == null) {
        return ('User Not Logged In', null);
      }
      return (null, int.tryParse(id.toString()));
    } catch (e) {
      log('Error checking logged in users : $e');
      return (e.toString(), null);
    }
  }

  @override
  Future<(String?, User?)> getUser(
      {int? id, String? email, String? username}) async {
    try {
      if (id == null && email == null && username == null) {
        return ('No criteria provided', null);
      }

      final whereClauses = <String>[];
      final whereArgs = <dynamic>[];

      if (id != null) {
        whereClauses.add('id = ?');
        whereArgs.add(id);
      }
      if (email != null) {
        whereClauses.add('email = ?');
        whereArgs.add(email);
      }
      if (username != null) {
        whereClauses.add('username = ?');
        whereArgs.add(username);
      }

      final users = await _db.query(
        'users',
        where: whereClauses.join(' OR '),
        whereArgs: whereArgs,
      );

      if (users.isEmpty) {
        return ('User not found', null);
      }

      final user = User.fromJson(users.first);
      return (null, user);
    } catch (e) {
      log('Error fetching user: $e');
      return (e.toString(), null);
    }
  }

  @override
  Future<(String?, void)> setMasterPin({required int id, required int pin}) {
    // TODO: implement setMasterPin
    throw UnimplementedError();
  }

  @override
  Future<(String?, void)> setLoggedInUser({required int id}) async{
    try {
      await _localStorage.write(key: AppConstant.localUserId, value: id.toString());
      return (null, null);
    } catch (e) {
      log('Error setting logged in user: $e');
      return (e.toString(), null);
    }
  }
}
