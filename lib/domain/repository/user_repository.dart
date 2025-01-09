import 'package:nort/data/model/user_model.dart';

abstract class UserRepository {
  Future<(String? , int?)> addUser({required User user});
  Future<(String? , List<User>?)> getAllUsers();
  Future<(String? , User?)> getUser({ int? id, String? email, String? username});
  Future<(String? , void)> setMasterPin({required int id , required int pin});
  Future <(String? , int?)> checkLoggedInUser();
  Future <(String? , void)> setLoggedInUser({required int id});
}