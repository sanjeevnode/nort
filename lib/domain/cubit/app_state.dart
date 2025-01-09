
part of 'app_cubit.dart';

class AppState extends Equatable {
 const AppState({
    this.user,
   this.registerStatus = Status.none,
    this.loginStatus = Status.none,
  });

  final User? user;
  final Status registerStatus;
  final Status loginStatus ;

  AppState copyWith({
    User? user,
    Status? registerStatus,
    Status? loginStatus,
  }) {
    return AppState(
      user: user ?? this.user,
      registerStatus: registerStatus ?? this.registerStatus,
      loginStatus: loginStatus ?? this.loginStatus,
    );
  }

  @override
  List<Object?> get props => [user, registerStatus, loginStatus];

  @override
  bool get stringify => true;

}