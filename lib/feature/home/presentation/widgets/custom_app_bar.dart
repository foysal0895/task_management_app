import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskmanager/settings/controller/theme_change_toggle.dart';
import '../../../auth/presentation/screen/sign_in_screen.dart';
import '../../../data/provider/auth_provider.dart';


class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.green,
      title: const Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(Icons.person, color: Colors.green),
          ),
          SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Md.Foysal islam Didar",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              Text(
                "mdfoysal@gmail.com",
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ],
          ),
        ],
      ),

      actions: [
        const ThemeChangeToggle(),
        IconButton(
          icon: const Icon(Icons.logout, color: Colors.white),
          onPressed: () => _onLogout(context),
        ),
      ],
    );
  }

  void _onLogout(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    await authProvider.signOut();

    if (context.mounted) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        SignInScreen.name,
            (route) => false,
      );
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
