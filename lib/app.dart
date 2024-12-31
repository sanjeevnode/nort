import 'package:flutter/material.dart';
import 'package:nort/routes/app_router.dart';
import 'package:nort/theme/app_theme.dart';
import 'package:nort/view/login_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const _AppView();
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
