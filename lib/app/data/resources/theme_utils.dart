import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/constants.dart';

TextStyle styleLight = TextStyle(color: Get.theme.colorScheme.onPrimary, fontFamily: "Poppins");
TextStyle styleDark = TextStyle(color: Get.theme.colorScheme.onPrimary, fontFamily: "Poppins");

class ThemeUtils {
  static ThemeData getLightTheme() {
    return ThemeData(
      // primarySwatch: Colors.grey,
      // primaryColor: Colors.white,
      brightness: Brightness.light,
      hintColor: Colors.black,
      dividerColor: Colors.white54,
      iconButtonTheme: const IconButtonThemeData(
          style: ButtonStyle(iconColor: MaterialStatePropertyAll<Color>(Colors.black))),
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
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue,
        background: const Color(0xFFE5E5E5),
        brightness: Brightness.light,
      ),
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
          style: ButtonStyle(iconColor: MaterialStatePropertyAll<Color>(Colors.white))),
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
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue,
        background: const Color(0xFF212121),
        brightness: Brightness.dark,
      ),
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
