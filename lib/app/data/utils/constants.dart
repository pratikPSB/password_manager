import 'package:password_manager/app/data/utils/prefs_utils.dart';

//region --------------------------------- Password Validate ---------------------------------

final passwordRegEx =
    RegExp("^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@\u0024%^&*-]).{8,}\u0024");

bool isPasswordValid(String text) => passwordRegEx.hasMatch(text);
//endregion

Prefs prefs() => Prefs();
const String prefKeyTheme = "pref_theme";
const String prefKeyLocale = "pref_locale";
const String prefKeyUser = "pref_user";
