import 'package:flutter/material.dart';

class DarkThemeData {
  static ThemeData get theme => ThemeData(
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFFFA500),
          brightness: Brightness.dark,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF030a0e),
          scrolledUnderElevation: 0,
        ),
        scaffoldBackgroundColor: const Color(0xFF030a0e),
        cardTheme: const CardTheme(color: Color(0xFF081017)),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF030a0e),
          selectedItemColor: Color(0xFFFFA500),
          unselectedItemColor: Colors.white54,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          enableFeedback: false,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
        ),
        dialogTheme: const DialogTheme(
          backgroundColor: Color(0xFF030a0e),
        ),
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Color(0xFF030a0e),
        ),
        hoverColor: const Color(0xFF081017),
        focusColor: const Color(0xFF081017),
        highlightColor: const Color(0xFF081017),
        snackBarTheme: const SnackBarThemeData(
          backgroundColor: Color(0xFF081017),
          contentTextStyle: TextStyle(color: Colors.white),
          actionTextColor: Color(0xFFFFA500),
        ),
      );
}
