part of 'app_cubit.dart';

class AppState extends Equatable {
  const AppState({
    this.user,
    this.registerStatus = Status.none,
    this.loginStatus = Status.none,
    this.logoutStatus = Status.none,
    this.pinStatus = Status.none,
    this.navType = NavType.home,
    this.navAction,
    this.showLoadingOverlay = false,
  });

  final User? user;
  final Status registerStatus;
  final Status loginStatus;
  final Status logoutStatus;
  final Status pinStatus;

  final NavType navType;
  final Widget? navAction;

  final bool showLoadingOverlay;

  AppState copyWith({
    User? user,
    Status? registerStatus,
    Status? loginStatus,
    Status? logoutStatus,
    Status? pinStatus,
    NavType? navType,
    Widget? navAction,
    bool? showLoadingOverlay,
  }) {
    return AppState(
      user: user ?? this.user,
      registerStatus: registerStatus ?? this.registerStatus,
      loginStatus: loginStatus ?? this.loginStatus,
      logoutStatus: logoutStatus ?? this.logoutStatus,
      pinStatus: pinStatus ?? this.pinStatus,
      navType: navType ?? this.navType,
      navAction: navAction ?? this.navAction,
      showLoadingOverlay: showLoadingOverlay ?? this.showLoadingOverlay,
    );
  }

  @override
  List<Object?> get props => [
        user,
        registerStatus,
        loginStatus,
        logoutStatus,
        pinStatus,
        navType,
        navAction,
        showLoadingOverlay,
      ];

  @override
  bool get stringify => true;
}
