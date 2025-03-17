import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:nort/core/core.dart';
import 'package:nort/data/data.dart';
import 'package:nort/domain/domain.dart';
import 'package:nort/ui/ui.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit({
    required UserRepository userRepository,
    required NoteRepository noteRepository,
  })  : _userRepository = userRepository,
        _noteRepository = noteRepository,
        super(const AppState());

  final UserRepository _userRepository;
  final NoteRepository _noteRepository;

  Future<void> init() async {
    final (_, id) = await _userRepository.checkLoggedInUser();
    if (id != null) {
      final (_, user) = await _userRepository.getUser(id: id);
      emit(state.copyWith(user: user));
      log('Init User: $user');
    }
    if (state.user != null) {
      await getNotes();
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
    final (err, _) = await _userRepository.addUser(user: user);
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
    if (state.user != null) {
      await getNotes();
    }
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

  void setShowLoadingOverlay(bool show) {
    emit(state.copyWith(showLoadingOverlay: show));
  }

  ///************* Note *********************/

  /// Get Notes
  Future<void> getNotes() async {
    try {
      emit(state.copyWith(showLoadingOverlay: true));
      final (err, notes) = await _noteRepository.getNotes();
      if (err != null) {
        throw err;
      }
      emit(state.copyWith(notes: notes ?? []));
    } catch (e) {
      handleError(e.toAppException());
    } finally {
      emit(state.copyWith(showLoadingOverlay: false));
    }
  }

  /// Add Note
  Future<int?> addNote({
    required String title,
    required String content,
    required String pin,
  }) async {
    try {
      emit(state.copyWith(showLoadingOverlay: true));
      final note = Note(
        userId: state.user!.id!,
        title: title,
        content: content,
      );
      final (err, id) = await _noteRepository.addNote(
        note,
        pin,
      );
      if (err != null) {
        throw err;
      }
      if (id != null) {
        await getNotes();
      }
      return id;
    } catch (e) {
      handleError(e.toAppException());
      return null;
    } finally {
      emit(state.copyWith(showLoadingOverlay: false));
    }
  }

  /// Get Dcrypted Note
  Future<Note?> getDcryptedNote({
    required int id,
    required String pin,
  }) async {
    try {
      emit(state.copyWith(showLoadingOverlay: true));
      final (err, note) = await _noteRepository.dcryptNote(
        id,
        pin,
      );
      if (err != null) {
        throw err;
      }
      return note;
    } catch (e) {
      handleError(e.toAppException());
      return null;
    } finally {
      emit(state.copyWith(showLoadingOverlay: false));
    }
  }

  /// Update Note
  Future<int?> updateNote({
    required Note note,
    required String pin,
  }) async {
    try {
      emit(state.copyWith(showLoadingOverlay: true));
      final (err, id) = await _noteRepository.updateNote(
        note,
        pin,
      );
      if (err != null) {
        throw err;
      }
      if (id != null) {
        await getNotes();
      }
      return id;
    } catch (e) {
      handleError(e.toAppException());
      return null;
    } finally {
      emit(state.copyWith(showLoadingOverlay: false));
    }
  }

  /// Delete Note
  Future<bool> deleteNote({
    required Note note,
  }) async {
    try {
      emit(state.copyWith(showLoadingOverlay: true));
      final (err, deleted) = await _noteRepository.deleteNote(
        note,
      );
      if (err != null) {
        throw err;
      }
      if (deleted) {
        await getNotes();
      }
      return deleted;
    } catch (e) {
      handleError(e.toAppException());
      return false;
    } finally {
      emit(state.copyWith(showLoadingOverlay: false));
    }
  }
}
