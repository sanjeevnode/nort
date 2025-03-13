import 'package:flutter/material.dart';
import 'package:nort/ui/ui.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRouteNames.login:
        return _buildMaterialPageRoute(
          const LoginScreen(),
          name: AppRouteNames.login,
        );
      case AppRouteNames.onboarding:
        return _buildMaterialPageRoute(
          const Onboarding(),
          name: AppRouteNames.onboarding,
        );

      case AppRouteNames.home:
        return _buildMaterialPageRoute(
          const HomePage(),
          name: AppRouteNames.home,
        );
      case AppRouteNames.register:
        return _buildMaterialPageRoute(
          const RegisterScreen(),
          name: AppRouteNames.register,
        );
      case AppRouteNames.enterPassword:
        return _buildMaterialPageRoute(
          const EnterMasterPassword(),
          name: AppRouteNames.enterPassword,
        );
      default:
        return _buildMaterialPageRoute(const Scaffold());
    }
  }

  static Route<dynamic> _buildMaterialPageRoute(Widget widget, {String? name}) {
    return MaterialPageRoute(
      builder: (_) => widget,
      settings: RouteSettings(name: name),
    );
  }
}
