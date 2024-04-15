import 'package:encrypt/encrypt.dart';

class EncryptData {
  static String encryptAES(encKey, plainText) {
    Encrypted? encrypted;
    final key = Key.fromUtf8(encKey);
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key));
    encrypted = encrypter.encrypt(plainText, iv: iv);
    return encrypted.base64;
  }

  static decryptAES(encKey, encryptedText) {
    final key = Key.fromUtf8(encKey);
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key));
    return encrypter.decrypt(Encrypted.fromBase64(encryptedText), iv: iv);
  }
}
