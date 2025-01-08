import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nort/data/repository/user_repository_impl.dart';
import 'package:nort/domain/cubit/app_cubit.dart';
import 'package:sqflite/sqflite.dart';

import 'core/theme/app_theme.dart';
import 'ui/routes/app_router.dart';
import 'ui/view/login_screen.dart';

class App extends StatelessWidget {
  const App({
    super.key,
    required UserRepositoryImpl userRepository,
    required Database db,
  })  : _userRepository = userRepository,
        _db = db;

  final UserRepositoryImpl _userRepository;
  final Database _db;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit(
            userRepository: _userRepository,
          ),
        ),
      ],
      child: const _AppView(),
    );
  }
}

class _AppView extends StatefulWidget {
  const _AppView({super.key});

  @override
  State<_AppView> createState() => _AppViewState();
}

class _AppViewState extends State<_AppView> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.standard,
      title: 'Nort',
      debugShowCheckedModeBanner: false,
      builder: (context, widget) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.noScaling,
          ),
          child: Stack(
            children: [
              ScrollConfiguration(
                behavior: const ScrollBehaviorModified(),
                child: widget!,
              ),
            ],
          ),
        );
      },
      onGenerateRoute: AppRouter.onGenerateRoute,
      home: const LoginScreen(),
    );
  }
}
