import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nort/data/model/user_model.dart';
import 'package:nort/domain/repository/user_repository.dart';


part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit({
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(const AppState());

  final UserRepository _userRepository;

  Future<void> register({
    required String username,
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(isAddingUser: true));
    final User user = User(
      username: username,
      email: email,
      password: password,
    );
    final int id = await _userRepository.addUser(user);
    log('User added with id: $id');
   await Future.delayed(const Duration(seconds: 2));
    emit(state.copyWith(isAddingUser: false));
  }

  Future<void> fetchUsers() async {
    final List<User> users = await _userRepository.getAllUsers();
    log('Users: $users');
    if (users.isNotEmpty) {
      emit(state.copyWith(user: users.first));
    }
  }
}
