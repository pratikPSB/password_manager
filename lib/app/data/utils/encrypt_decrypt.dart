import 'dart:convert';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:password_manager/app/data/utils/constants.dart';

/*class EncryptData {
  static String encryptAES(encKey, plainText) {
    Encrypted? encrypted;
    final key = Key.fromUtf8(encKey);
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key));
    encrypted = encrypter.encrypt(plainText, iv: iv);
    return encrypted.base64;
  }

  static decryptAES(encKey, encryptedText) {
    final Uint8List encryptedBytesWithSalt = base64.decode(encryptedText);
    final key = Key.fromUtf8(encKey);
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key));
    return encrypter.decrypt(Encrypted.fromBase64(encryptedText), iv: iv);
  }
}*/

class EncryptionUtils {
  static late encrypt.IV iv;
  late String aesEncryptionKey;
  static late encrypt.Encrypter encrypter;

  // Private constructor
  EncryptionUtils._() {
    aesEncryptionKey = finalKey;
    iv = encrypt.IV.fromUtf8(aesEncryptionKey);
    encrypter = encrypt.Encrypter(encrypt.AES(encrypt.Key.fromUtf8(aesEncryptionKey),
        mode: encrypt.AESMode.ctr, padding: null));
  }

  // Public factory method to initialize the class
  static Future<void> initialize() async {
    await _getInstance()._initialize();
  }

  Future<void> _initialize() async {
    aesEncryptionKey = finalKey;
    iv = encrypt.IV.fromUtf8(aesEncryptionKey);
    encrypter = encrypt.Encrypter(encrypt.AES(encrypt.Key.fromUtf8(aesEncryptionKey),
        mode: encrypt.AESMode.ctr, padding: null));
  }

  // Private method to get the instance of EncryptionUtils
  static EncryptionUtils _getInstance() {
    return EncryptionUtils._();
  }

  static String encryptAES(String text) => encrypter.encrypt(text, iv: iv).base64;

  static String decryptAES(String encrypted) {
    final Uint8List encryptedBytesWithSalt = base64.decode(encrypted);
    final Uint8List encryptedBytes = encryptedBytesWithSalt.sublist(
      0,
      encryptedBytesWithSalt.length,
    );
    final String decrypted = encrypter.decrypt64(base64.encode(encryptedBytes), iv: iv);
    return decrypted;
  }
}
