import 'package:nort/core/app_error.dart';
import 'package:nort/data/model/user_model.dart';

abstract class UserRepository {
  Future<(AppException? , int?)> addUser({required User user});

  Future<(AppException? , List<User>?)> getAllUsers();

  Future<(AppException? , User?)> getUser({ int? id, String? email, String? username});

  Future<(AppException? , void)> setMasterPin({required int id , required int pin});

  Future <(AppException? , int?)> checkLoggedInUser();

  Future <(AppException? , void)> setLoggedInUser({required int id});

  Future <(AppException? , User?)> login({required String email, required String password});

  Future <(AppException? , void)> logout();



}