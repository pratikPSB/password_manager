import 'dart:math' as math;

const String _smallLetters = "a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z",
    _capitalLetters = "A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z",
    _numbers = "0,1,2,3,4,5,6,7,8,9",
    _symbols = "~,!,@,#,\$,%,^,&,*,(,),_,+,-,{,},\\,[,],;,:,.,/,?";

extension CheckStrength on String? {
  /// An extension on the [String] type to make you able to check the strength of
  /// any string without the need to initialize the [PasswordGenerator] class.
  ///
  /// The extension returns the entropy of the string provided, the bigger the entropy
  /// the stronger the string.
  ///
  /// The entropy gets calculated considering the string length, how many capital
  /// letters it contains, how many small letters it contains, how many numbers
  /// it contains and how many symbols it contains.
  ///
  /// Ranges Are:
  ///
  /// More than or equal to 128: Extremely Strong.
  ///
  /// More than or equal to 60: Very Strong.
  ///
  /// More than or equal to 36: Strong.
  ///
  /// More than or equal to 28: Ok.
  ///
  /// More than or equal to 18: Weak.
  ///
  /// Less than 18: Extremely Weak.
  ///
  /// Example:
  ///
  /// ```
  /// final double _entropy = _password.checkStrength();
  ///
  ///   if (_entropy >= 128) {
  ///     print('Extremely Strong.');
  ///   } else if (_entropy >= 60) {
  ///     print('Very Strong.');
  ///   } else if (_entropy >= 36) {
  ///     print('Strong.');
  ///   } else if (_entropy >= 28) {
  ///     print('Ok.');
  ///   } else if (_entropy >= 18) {
  ///     print('Weak.');
  ///   } else {
  ///     print('Extremely Weak.');
  ///   }
  /// ```
  double checkStrength() {
    if (this != null) {
      if (this!.isNotEmpty) {
        int pool = 0,
            smallLettersCount = 0,
            capitalLettersCount = 0,
            numbersCount = 0,
            symbolsCount = 0;

        for (int i in this!.runes) {
          if (_capitalLetters.runes.contains(i)) {
            capitalLettersCount += 1;
          }

          if (_smallLetters.runes.contains(i)) {
            smallLettersCount += 1;
          }

          if (_numbers.runes.contains(i)) {
            numbersCount += 1;
          }

          if (_symbols.runes.contains(i)) {
            symbolsCount += 1;
          }
        }

        if (smallLettersCount > 0) {
          pool += 26;
        }

        if (capitalLettersCount > 0) {
          pool += 26;
        }

        if (numbersCount > 0) {
          pool += 10;
        }

        if (symbolsCount > 0) {
          pool += 32;
        }

        int length = smallLettersCount + capitalLettersCount + numbersCount + symbolsCount;

        var entropy = length * math.log(pool) / math.log(2);

        if (pool > 0) {
          return entropy;
        }
      }
    }

    return 0;
  }
}

/// [PasswordGenerator] is a class that can be used to generate strong passwords
/// to be used in all kinds of applications.
///
/// Example:
/// ```
/// final _passwordGenerator = PasswordGenerator(
///     length: 10,
///     hasCapitalLetters: true,
///     hasNumbers: true,
///     hasSmallLetters: true,
///     hasSymbols: true,
///   );
///
/// final String _password = _passwordGenerator.generatePassword();
/// ```
class PasswordGenerator {
  /// A boolean value to tell if the password should have capital letters
  /// in it or not. defaults to true.
  late bool hasCapitalLetters;

  /// A boolean value to tell if the password should have small letters in
  /// it or not. defaults to true.
  late bool hasSmallLetters;

  /// A boolean value to tell if the password should have numbers in it or not.
  /// defaults to true.
  late bool hasNumbers;

  /// A boolean value to tell if the password should have symbols in it or not.
  /// defaults to true.
  late bool hasSymbols;

  /// An integer value that indicates the length of the password.
  /// defaults to 10.
  late int length;

  /// Generates new random password.
  String generatePassword() {
    final List<String> chars = [];
    final random = math.Random.secure();
    String password = "";

    if (hasCapitalLetters) {
      chars.addAll(_capitalLetters.split(','));
    }

    if (hasSmallLetters) {
      chars.addAll(_smallLetters.split(','));
    }

    if (hasNumbers) {
      chars.addAll(_numbers.split(','));
    }

    if (hasSymbols) {
      chars.addAll(_symbols.split(','));
    }

    chars.shuffle();

    for (var i = 0; i < length; i++) {
      String char = chars[random.nextInt(chars.length)];

      password += char;
    }

    return password;
  }

  PasswordGenerator({
    this.hasCapitalLetters = true,
    this.hasSmallLetters = true,
    this.hasNumbers = true,
    this.hasSymbols = true,
    this.length = 10,
  })  : assert(
          hasCapitalLetters || hasNumbers || hasSmallLetters || hasSymbols,
          'At least one of the conditions must be true.',
        ),
        assert(
          length > 0,
          'length must be more than 0.',
        );
}
