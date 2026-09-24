import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_projects/core/routes/app_routes.dart';
import 'package:flutter_projects/features/auth/presentation/ui/login_screen.dart';
import 'package:flutter_projects/features/auth/presentation/ui/register_screen.dart';
import 'package:flutter_projects/features/profile/presentation/ui/profile_setup_screen.dart';

class AppRouter {
  static Route<dynamic>? onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.loginScreen:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
          settings: settings,
        );
      case AppRoutes.registerScreen:
        return MaterialPageRoute(
          builder: (_) => const RegisterScreen(),
          settings: settings,
        );
      case AppRoutes.profileSetupScreen:
        final uid = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => ProfileSetupScreen(uid: uid),
          settings: settings,
        );
      case AppRoutes.homeScreen:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Home Screen'),
            ),
          ),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
          settings: settings,
        );
    }
  }
}
