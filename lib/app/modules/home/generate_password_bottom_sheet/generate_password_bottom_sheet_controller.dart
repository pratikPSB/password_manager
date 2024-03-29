import 'package:get/get.dart';
import 'package:password_manager/app/data/customClasses/password_generator.dart';

class GeneratePasswordBottomSheetController extends GetxController {
  PasswordGenerator passwordGenerator = PasswordGenerator(
      hasCapitalLetters: true,
      hasSmallLetters: true,
      hasSymbols: true,
      hasNumbers: true,
      length: 16);
  RxString password = "".obs;
  RxString pwdStrength = "".obs;
  RxInt pwdLength = 16.obs;
  RxBool enableSpecialChars = true.obs;
  RxBool enableCapLetters = true.obs;
  RxBool enableNumbers = true.obs;

  createPassword({Function(String password, String pwdStrength)? onPasswordGenerated}) {
    final String password = passwordGenerator.generatePassword();
    final double entropy = password.checkStrength();
    String pwdStrength = "";
    // We then check the entropy value and print information related to the specified ranges.
    if (entropy >= 128) {
      pwdStrength = "Extremely Strong.";
    } else if (entropy >= 60) {
      pwdStrength = "Very Strong.";
    } else if (entropy >= 36) {
      pwdStrength = "Strong.";
    } else if (entropy >= 28) {
      pwdStrength = "Ok.";
    } else if (entropy >= 18) {
      pwdStrength = "Weak.";
    } else {
      pwdStrength = "Extremely Weak.";
    }
    this.password.value = password;
    this.pwdStrength.value = pwdStrength;
    if (onPasswordGenerated != null) onPasswordGenerated(password, pwdStrength);
  }

  updatePwdLengthOption(int value) {
    passwordGenerator.length = value;
    pwdLength.value = value;
    createPassword();
  }

  updateSpecialCharOption(bool value) {
    passwordGenerator.hasSymbols = value;
    enableSpecialChars.value = value;
    createPassword();
  }

  updateCapitalLettersOption(bool value) {
    passwordGenerator.hasCapitalLetters = value;
    enableCapLetters.value = value;
    createPassword();
  }

  updateNumberOption(bool value) {
    passwordGenerator.hasNumbers = value;
    enableNumbers.value = value;
    createPassword();
  }
}
