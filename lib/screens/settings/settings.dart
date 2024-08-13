import 'package:flutter/material.dart';
import 'package:mobile/app_localization.dart';
import 'package:mobile/screens/settings/language.dart';
import 'package:mobile/screens/settings/theme.dart';
import 'package:mobile/widgets/appbar.dart';

Route _createThemeSettingsRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        ThemeSettingsScreen(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.easeOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);

      // Apply the animation using SlideTransition
      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}

Route _createLanguageSettings() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        LanguageSettingsScreen(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.easeOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);

      // Apply the animation using SlideTransition
      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: Text(
          AppLocalizations.of(context)!.translate("settings"),
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(
              AppLocalizations.of(context)!.translate("theme"),
            ),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {
              Navigator.of(context).push(_createThemeSettingsRoute());
            },
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.translate("language")),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {
              Navigator.of(context).push(_createLanguageSettings());
            },
          )
        ],
      ),
    );
  }
}
