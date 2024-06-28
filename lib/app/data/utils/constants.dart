import 'package:password_manager/app/data/utils/prefs_utils.dart';

//region --------------------------------- Password Validate ---------------------------------

final passwordRegEx =
    RegExp("^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@\u0024%^&*-]).{8,}\u0024");

bool isPasswordValid(String text) => passwordRegEx.hasMatch(text);
//endregion

String s1 =
    "kajdshcilbrevbqvilfbulqewb478b14387b2o84vbrelbaqwycb8qewbcqb843vb1qcwbqecuyqvbre8p43cb";
String finalKey = s1.substring(20, 20 + 32);


Prefs prefs() => Prefs();
const String prefKeyTheme = "pref_theme";
const String prefKeyLocale = "pref_locale";
const String prefKeyUser = "pref_user";
const String prefHapticFeedbackEnabled = "pref_haptic_feedback_enabled";
const String prefSelectedVaultId = "pref_selected_vault_id";

enableHapticFeedback({bool isEnabled = true}) {
  prefs().setBoolean(prefHapticFeedbackEnabled, isEnabled);
}

Future<bool> isHapticFeedbackEnabled() => prefs().getBoolean(prefHapticFeedbackEnabled);
