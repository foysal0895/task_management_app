import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskmanager/feature/controller/providers/main_nav_provider.dart';
import 'package:taskmanager/feature/home/presentation/screen/canceled_task_screen.dart';
import 'package:taskmanager/feature/home/presentation/screen/new_task_screen.dart';

import '../home/presentation/screen/complete_task_screen.dart';
import '../home/presentation/screen/progress_task.dart';

class MainNavHolder extends StatefulWidget {
  const MainNavHolder({super.key});
static const String name="/main_nav";
  @override
  State<MainNavHolder> createState() => _MainNavHolderState();
}

class _MainNavHolderState extends State<MainNavHolder> {


  final List<Widget>_screenList=[
    NewTaskScreen(),
    CompleteTaskScreen(),
    CanceledTaskScreen(),
    ProgressTaskScreen()

  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<MainNavProvider>(
      builder: (context,mainNavProvider,_) {
        return Scaffold(
          body: _screenList[mainNavProvider.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
               selectedItemColor: Colors.greenAccent,
               showSelectedLabels: true,
               showUnselectedLabels: true,
               unselectedItemColor: Colors.grey,
               currentIndex: mainNavProvider.currentIndex,
              onTap:mainNavProvider.changeIndex,
              items:[
                BottomNavigationBarItem(icon: Icon(Icons.receipt),label: "New Task"),
                BottomNavigationBarItem(icon: Icon(Icons.incomplete_circle),label: "completed"),
                BottomNavigationBarItem(icon: Icon(Icons.cancel),label: "canceled"),
                BottomNavigationBarItem(icon: Icon(Icons.padding_outlined),label: "progress"),

              ],
          ),
        );
      }
    );
  }
}
