import 'dart:convert';

import 'package:encrypt/encrypt.dart';

String getEncrypted(plainText) {

  final key = Key.fromUtf8('4181415141f181418141a18498b49f46');
//  final key = Key.fromUtf8('4089415240f487468541a08498b49f46');
  final iv = IV.fromUtf8('5135849584521655');
  final encrypter = Encrypter(AES(key, mode: AESMode.cbc, padding: 'PKCS7'));
  final encrypted = encrypter.encrypt(jsonEncode(plainText), iv: iv);
  return '2'+encrypted.base64;
}