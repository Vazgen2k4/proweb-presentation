import 'package:flutter/material.dart';
import 'package:proweb_presentations_web/ui/pages/auth/auth_page.dart';
import 'package:proweb_presentations_web/ui/pages/error_404_page/error_404_page.dart';
import 'package:proweb_presentations_web/ui/pages/home_page/home_page.dart';
import 'package:proweb_presentations_web/ui/pages/settings/settings_page.dart';

abstract class AppRoutes {
  AppRoutes._();
  static const String home = '/';
  static const String settings = '/settings';
  static const String auth = '/auth';
}

class AppNavigator {
  static String initRoute = AppRoutes.home;

  static Map<String, WidgetBuilder> get routes {
    return {
      AppRoutes.home: (_) => const HomePage(),
      AppRoutes.settings: (_) => const SettingsPage(),
      AppRoutes.auth: (_) => const AuthPage(),
    };
  }

  static Route generate(RouteSettings settings) {
    print(settings.name);
    final _settings = RouteSettings(
      name: '/404',
      arguments: settings.arguments,
    );

    return MaterialPageRoute(
      settings: _settings,
      builder: (_) => const Error404Page(),
    );
  }
}
