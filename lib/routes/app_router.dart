import 'package:flutter/material.dart';
import 'package:nort/view/home.dart';
import 'package:nort/view/login_screen.dart';
import 'package:nort/view/onboarding.dart';

import 'app_route_name.dart';

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
