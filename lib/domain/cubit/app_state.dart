part of 'app_cubit.dart';

class AppState extends Equatable {
  const AppState({
    this.user,
    this.registerStatus = Status.none,
    this.loginStatus = Status.none,
    this.logoutStatus = Status.none,
  });

  final User? user;
  final Status registerStatus;
  final Status loginStatus;
  final Status logoutStatus;

  AppState copyWith({
    User? user,
    Status? registerStatus,
    Status? loginStatus,
    Status? logoutStatus,
  }) {
    return AppState(
      user: user ?? this.user,
      registerStatus: registerStatus ?? this.registerStatus,
      loginStatus: loginStatus ?? this.loginStatus,
      logoutStatus: logoutStatus ?? this.logoutStatus,
    );
  }

  @override
  List<Object?> get props => [user, registerStatus, loginStatus, logoutStatus];

  @override
  bool get stringify => true;
}
