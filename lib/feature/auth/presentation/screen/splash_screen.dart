import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taskmanager/app/assets_path.dart';
import 'package:taskmanager/feature/auth/presentation/screen/sign_in_screen.dart';
import 'package:taskmanager/feature/controller/main_nav_holder.dart';


import '../widgets/app_back_image.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String name = "/splash";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    _moveToNextScreen();
    super.initState();
  }

  Future<void> _moveToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        MainNavHolder.name,
        (predicate) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          AppBackGroundImage(),
          SvgPicture.asset(AssetsPath.logoImage),
        ],
      ),
    );
  }
}
