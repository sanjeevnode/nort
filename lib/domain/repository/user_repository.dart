import 'package:nort/data/model/user_model.dart';

abstract class UserRepository {
  Future<int> addUser(User user);
  Future<List<User>> getAllUsers();
}