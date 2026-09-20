import 'package:flutter/material.dart';
import 'package:flutter_projects/core/di/service_locator.dart';
import 'package:flutter_projects/features/auth/data/auth_service.dart';

import 'core/routes/app_router.dart';
import 'core/routes/app_routes.dart';

class SkillRadarApp extends StatelessWidget {
  const SkillRadarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SkillRadar',
      debugShowCheckedModeBanner: false,
      initialRoute: _getInitialPage(),
      onGenerateRoute: AppRouter.onGenerateRoutes,
    );
  }

  String _getInitialPage() {
    final bool isLoggedIn = getIt<AuthService>().isUserLoggedIn();
    return isLoggedIn ? AppRoutes.homeScreen : AppRoutes.loginScreen;
  }
}
