import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:nort/core/app_error.dart';
import 'package:nort/core/constants/status.dart';
import 'package:nort/core/toast.dart';
import 'package:nort/data/model/user_model.dart';
import 'package:nort/domain/repository/user_repository.dart';
import 'package:nort/ui/enums/navtype.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit({
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(const AppState());

  final UserRepository _userRepository;

  Future<void> init() async {
    final (err, id) = await _userRepository.checkLoggedInUser();
    if (id != null) {
      final (err, user) = await _userRepository.getUser(id: id);
      emit(state.copyWith(user: user));
      log('Init User: $user');
    }
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
      handleError(err);
      emit(state.copyWith(registerStatus: Status.error));
      return;
    }
    emit(state.copyWith(registerStatus: Status.success));
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(loginStatus: Status.loading));
    final (err, user) =
        await _userRepository.login(email: email, password: password);
    if (err != null || user == null) {
      handleError(err);
      emit(state.copyWith(loginStatus: Status.error));
      return;
    }
    await _userRepository.setLoggedInUser(id: user.id!);
    emit(state.copyWith(loginStatus: Status.success, user: user));
  }

  Future<void> logout() async {
    emit(state.copyWith(logoutStatus: Status.loading));
    final (err, _) = await _userRepository.logout();
    if (err != null) {
      handleError(err);
      emit(state.copyWith(logoutStatus: Status.error));
      return;
    }
    emit(
      state.copyWith(
        logoutStatus: Status.success,
      ),
    );
  }

  Future<void> setMasterPin({
    required String pin,
  }) async {
    emit(state.copyWith(pinStatus: Status.loading));
    final (err, _) = await _userRepository.setMasterPin(
      id: state.user!.id!,
      pin: int.parse(pin),
    );
    if (err != null) {
      handleError(err);
      emit(state.copyWith(pinStatus: Status.error));
      return;
    }
    emit(state.copyWith(pinStatus: Status.success));
  }

  void reset() {
    emit(const AppState());
  }

  void handleError(AppException? e) {
    if (e is UserNotFoundException) {
      Toast.error(e.message);
    } else if (e is UserAlreadyExistsException) {
      Toast.error(e.message);
    } else if (e is InvalidCredentialsException) {
      Toast.error(e.message);
    } else {
      Toast.error('An error occurred');
    }
  }

  /// Navigation
  void setNav(NavType navType) {
    emit(state.copyWith(navType: navType));
  }
}
