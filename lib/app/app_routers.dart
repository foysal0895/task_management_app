import 'package:flutter/material.dart';
import 'package:taskmanager/feature/auth/presentation/screen/sign_in_screen.dart';
import 'package:taskmanager/feature/auth/presentation/screen/sign_up_screen.dart';
import 'package:taskmanager/feature/auth/presentation/screen/splash_screen.dart';
import 'package:taskmanager/feature/controller/main_nav_holder.dart';
import 'package:taskmanager/feature/home/presentation/screen/add_new_task_screen.dart';
import 'package:taskmanager/feature/home/presentation/screen/canceled_task_screen.dart';
import 'package:taskmanager/feature/home/presentation/screen/complete_task_screen.dart';
import 'package:taskmanager/feature/home/presentation/screen/new_task_screen.dart';
import 'package:taskmanager/feature/home/presentation/screen/progress_task.dart';

class AppRouters {
  static Route<dynamic>? onGenerateRoute(RouteSettings setting) {
    Widget widget;
    switch (setting.name) {
      case SplashScreen.name:
        widget = const SplashScreen();
        break;
      case SignInScreen.name:
        widget = const SignInScreen();
        break;
      case NewTaskScreen.name:
        widget = const NewTaskScreen();
        break;
      case MainNavHolder.name:
        widget = const MainNavHolder();
        break;
      case ProgressTaskScreen.name:
        widget = const ProgressTaskScreen();
        break;
      case CanceledTaskScreen.name:
        widget = const CanceledTaskScreen();
        break;
      case CompleteTaskScreen.name:
        widget = const CompleteTaskScreen();
        break;
      case AddNewTaskScreen.name:
        widget = const AddNewTaskScreen();
        break;
      case SignUpScreen.name:
        widget = const SignUpScreen();
        break;
      default:
        widget = const Scaffold(
          body: Center(child: Text("Route not found")),
        );
    }
    return MaterialPageRoute(builder: (context) => widget);
  }
}
