import 'dart:developer';

import 'package:nort/core/app_error.dart';
import 'package:nort/core/constants/app_constant.dart';
import 'package:nort/core/utils/secure_hash.dart';
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
  Future<(AppException?, int?)> addUser({required User user}) async {
    try {
      final (_,existingUser) = await getUser(email: user.email);
      if (existingUser != null) {
        return (UserAlreadyExistsException(), null);
      }
      final sh = SecureHash.generate(user.password);
      final id = await _db.insert(
        'users',
        {
          'username': user.username,
          'email': user.email,
          'password': sh["hash"],
          'salt': sh["salt"],
        },
      );
      return (null, id);
    } catch (e) {
      return (e.toAppException(), null);
    }
  }

  @override
  Future<(AppException?, List<User>?)> getAllUsers() async {
    try {
      final List<Map<String, dynamic>> users = await _db.query('users');
      final u = users
          .map((Map<String, dynamic> user) => User.fromJson(user))
          .toList();
      return (null, u);
    } catch (e) {
      return (e.toAppException(), null);
    }
  }

  @override
  Future<(AppException?, int?)> checkLoggedInUser() async {
    try {
      final id = await _localStorage.read(key: AppConstant.localUserId);
      if (id == null) {
        return (UserNotLoggedInException(), null);
      }
      return (null, int.tryParse(id.toString()));
    } catch (e) {
      return (e.toAppException(), null);
    }
  }

  @override
  Future<(AppException?, User?)> getUser(
      {int? id, String? email, String? username}) async {
    try {
      if (id == null && email == null && username == null) {
        return (BadRequestException(message: 'Not Sufficient Data'), null);
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
        return (UserNotFoundException(), null);
      }

      final user = User.fromJson(users.first);
      return (null, user);
    } catch (e) {
      log('Error fetching user: $e');
      return (e.toAppException(), null);
    }
  }

  @override
  Future<(AppException?, void)> setMasterPin({required int id, required int pin}) async {
    try {
     final (_, user) = await getUser(id: id);
      if (user == null) {
        return (UserNotFoundException(), null);
      }
      final hashedPin = SecureHash.generateHashWithSalt(pin.toString(), user.salt!);
      await _db.update(
        'users',
        {
          'masterPassword': hashedPin,
        },
        where: 'id = ?',
        whereArgs: [id],
      );
      return (null, null);
    } catch (e) {
      return (e.toAppException(), null);
    }
  }

  @override
  Future<(AppException?, void)> setLoggedInUser({required int id}) async{
    try {
      await _localStorage.write(key: AppConstant.localUserId, value: id.toString());
      return (null, null);
    } catch (e) {
      return (e.toAppException(), null);
    }
  }

  @override
  Future<(AppException?, void)> logout()async {
    try {
      await _localStorage.delete(key: AppConstant.localUserId);
      return (null, null);
    } catch (e) {
      return (e.toAppException(), null);
    }
  }

  @override
  Future<(AppException?, User?)> login({required String email,required String password}) async{
    try {
      final (err, user) = await getUser(email: email);
      if (err != null || user == null) {
        return (err, null);
      }
      final isUser = SecureHash.compare(password, user.salt!, user.password);
      if (!isUser) {
        return (InvalidCredentialsException(), null);
      }
      return (null, user);
    } catch (e) {
      return (e.toAppException(), null);
    }
  }
}
