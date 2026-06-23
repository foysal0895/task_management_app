import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskmanager/app/app_routers.dart';
import 'package:taskmanager/app/app_theme.dart';
import 'package:taskmanager/feature/auth/presentation/screen/splash_screen.dart';
import 'package:taskmanager/settings/controller/provider/theme_change_provider.dart';

class TaskManager extends StatelessWidget {
  const TaskManager({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeChangeProvider>(
      builder: (context, themeProvider, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: SplashScreen.name,
          onGenerateRoute: AppRouters.onGenerateRoute,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeProvider.themeMode,
        );
      },
    );
  }
}
