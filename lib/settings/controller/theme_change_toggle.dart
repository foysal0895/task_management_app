import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskmanager/settings/controller/provider/theme_change_provider.dart';

class ThemeChangeToggle extends StatelessWidget {
  const ThemeChangeToggle({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeChangeProvider>(
      builder: (context, provider, _) {
        final isDark = provider.themeMode == ThemeMode.dark;
        return Switch(
          value: isDark,
          activeThumbColor: Colors.white,
          activeTrackColor: Colors.blue,
          inactiveThumbColor: Colors.white,
          inactiveTrackColor: Colors.grey,
          onChanged: (value) {
            final newMode = value ? ThemeMode.dark : ThemeMode.light;
            provider.changeTheme(newMode);
            provider.setThemeData(newMode);
          },
        );
      },
    );
  }
}
