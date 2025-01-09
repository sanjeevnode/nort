import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nort/core/constants/status.dart';
import 'package:nort/data/model/user_model.dart';
import 'package:nort/domain/repository/user_repository.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit({
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(const AppState());

  final UserRepository _userRepository;

  Future<void> init() async {
    log('1. AppCubit init');
    final (err, id) = await _userRepository.checkLoggedInUser();
    log('2. Got user id: $id');
    if (id != null) {
      final (err, user) = await _userRepository.getUser(id: id);
      log('3. User: $user');
      log('3. Error: $err');
      emit(state.copyWith(user: user));
      log('4. Emitting state user ${state.user} ');
    }
    log('AppCubit init done with id: $id');
  }

  Future<void> register({
    required String username,
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(registerStatus: Status.loading));
    final User user = User(
      username: username,
      email: email,
      password: password,
    );
    final (err, id) = await _userRepository.addUser(user: user);
    if (err != null) {
      log('Error registering user: $err');
      emit(state.copyWith(registerStatus: Status.error));
      return;
    }
    emit(state.copyWith(registerStatus: Status.success));
    log('Registered User: $id');
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(loginStatus: Status.loading));
    final (err, user) = await _userRepository.getUser(email: email);
    if (err != null || user == null) {
      emit(state.copyWith(loginStatus: Status.error));
      return;
    }
    log('Logged User: $user');
    await _userRepository.setLoggedInUser(id: user.id!);
    emit(state.copyWith(loginStatus: Status.success, user: user));
  }
}
