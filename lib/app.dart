import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nort/core/toast.dart';
import 'package:nort/domain/cubit/app_cubit.dart';
import 'package:nort/ui/view/home/home.dart';
import 'package:nort/ui/view/onboarding.dart';

import 'core/theme/app_theme.dart';
import 'ui/routes/app_router.dart';
import 'ui/view/login_screen.dart';

class App extends StatelessWidget {
  const App({
    super.key,
    required AppCubit appCubit,
  })  : _appCubit= appCubit;

final AppCubit _appCubit;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppCubit>.value(value: _appCubit),
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
    return BlocBuilder<AppCubit,AppState>(
      builder: (context,state) {
        final screen = state.user != null ? state.user!.masterPassword==null ? const Onboarding() :const HomePage() : const LoginScreen();
        return MaterialApp(
          scaffoldMessengerKey: Toast.scaffoldKey,
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
          home: screen,
        );
      }
    );
  }
}
