import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/constants.dart';

ColorScheme _lightColorScheme = ColorScheme.fromSeed(
  seedColor: const Color(0xFF20B6FA),
  surface: const Color(0xFFE5E5E5),
  brightness: Brightness.light,
);

ColorScheme _darkColorScheme = ColorScheme.fromSeed(
  seedColor: const Color(0xFF20B6FA),
  surface: const Color(0xFF212121),
  brightness: Brightness.dark,
);

TextStyle styleLight = TextStyle(color: _lightColorScheme.primary, fontFamily: "Poppins");
TextStyle styleDark = TextStyle(color: _darkColorScheme.primary, fontFamily: "Poppins");

class ThemeUtils {
  static ThemeData getLightTheme() {
    return ThemeData(
      // primarySwatch: Colors.grey,
      // primaryColor: Colors.white,
      brightness: Brightness.light,
      hintColor: Colors.black,
      dividerColor: Colors.white54,
      iconButtonTheme: const IconButtonThemeData(
          style: ButtonStyle(iconColor: WidgetStatePropertyAll<Color>(Colors.black))),
      textTheme: const TextTheme().copyWith(
        displayLarge: styleLight,
        displayMedium: styleLight,
        displaySmall: styleLight,
        headlineLarge: styleLight,
        headlineMedium: styleLight,
        headlineSmall: styleLight,
        titleLarge: styleLight,
        titleMedium: styleLight,
        titleSmall: styleLight,
        bodyLarge: styleLight,
        bodyMedium: styleLight,
        bodySmall: styleLight,
        labelLarge: styleLight,
        labelMedium: styleLight,
        labelSmall: styleLight,
      ),
      bottomSheetTheme: BottomSheetThemeData(backgroundColor: _lightColorScheme.secondaryContainer),
      useMaterial3: true,
      colorScheme: _lightColorScheme,
    );
  }

  static ThemeData getDarkTheme() {
    return ThemeData(
      // primarySwatch: Colors.grey,
      // primaryColor: Colors.black,
      brightness: Brightness.dark,
      hintColor: Colors.white,
      dividerColor: Colors.black12,
      iconButtonTheme: const IconButtonThemeData(
          style: ButtonStyle(iconColor: WidgetStatePropertyAll<Color>(Colors.white))),
      textTheme: const TextTheme().copyWith(
        displayLarge: styleDark,
        displayMedium: styleDark,
        displaySmall: styleDark,
        headlineLarge: styleDark,
        headlineMedium: styleDark,
        headlineSmall: styleDark,
        titleLarge: styleDark,
        titleMedium: styleDark,
        titleSmall: styleDark,
        bodyLarge: styleDark,
        bodyMedium: styleDark,
        bodySmall: styleDark,
        labelLarge: styleDark,
        labelMedium: styleDark,
        labelSmall: styleDark,
      ),
      bottomSheetTheme: BottomSheetThemeData(backgroundColor: _darkColorScheme.secondaryContainer),
      useMaterial3: true,
      colorScheme: _darkColorScheme,
    );
  }

  static void changeTheme(bool setLightTheme) {
    prefs().setBoolean(prefKeyTheme, setLightTheme);
    Get.changeThemeMode(setLightTheme ? ThemeMode.light : ThemeMode.dark);
  }

  static Future<ThemeMode> getThemeMode() async {
    ThemeMode mode = ThemeMode.system;
    if (await prefs().contains(prefKeyTheme)) {
      if (await prefs().getBoolean(prefKeyTheme)) {
        mode = ThemeMode.light;
      } else {
        mode = ThemeMode.dark;
      }
    }
    return mode;
  }
}
