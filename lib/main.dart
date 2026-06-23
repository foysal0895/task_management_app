import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskmanager/feature/controller/providers/main_nav_provider.dart';
import 'package:taskmanager/feature/home/provider/task_provider.dart';
import 'package:taskmanager/settings/controller/provider/theme_change_provider.dart';
import 'app/task_manager.dart';
import 'feature/data/provider/auth_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  final themeProvider = ThemeChangeProvider();
  await themeProvider.setDefaultTheme();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => TaskProvider()),
        ChangeNotifierProvider(create: (_) => MainNavProvider()),
        ChangeNotifierProvider(create: (_) => themeProvider),
      ],
      child: const TaskManager(),
    ),
  );
}
