import 'dart:convert';

import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:password_manager/app/data/utils/constants.dart';

class EncryptionUtils {
  late encrypt.Encrypter _encrypter;
  late final encrypt.IV _iv;

  static final EncryptionUtils _instance = EncryptionUtils._internal();

  factory EncryptionUtils() {
    return _instance;
  }

  EncryptionUtils._internal() {
    _encrypter = encrypt.Encrypter(encrypt.AES(encrypt.Key.fromUtf8(finalKey), padding: null));
    _iv = encrypt.IV.fromUtf8(finalKey.substring(5, 5 + 16));
  }

  String encryptAES(String plainText) {
    final encrypted = _encrypter.encrypt(plainText, iv: _iv);
    return base64.encode(encrypted.bytes);
  }

  String decryptAES(String encryptedText) {
    final decrypted = _encrypter.decrypt64(encryptedText, iv: _iv);
    return decrypted;
  }
}
