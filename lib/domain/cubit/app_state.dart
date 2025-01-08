
part of 'app_cubit.dart';

class AppState extends Equatable {
 const AppState({
    this.user,
   this.isAddingUser = false,
  });

  final User? user;
  final bool isAddingUser;

  AppState copyWith({
    User? user,
    bool? isAddingUser,
  }) {
    return AppState(
      user: user ?? this.user,
      isAddingUser: isAddingUser ?? this.isAddingUser,
    );
  }

  @override
  List<Object?> get props => [user, isAddingUser];

  @override
  bool get stringify => true;

}