import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';

class Hash {
  static String generate(String text) {
    final salt = _generateSalt();
    final bytes = utf8.encode(salt + text);
    final hash = sha256.convert(bytes);
    return '$salt\$${hash.toString()}';
  }

  static bool compare(String text, String saltedHash) {
    final parts = saltedHash.split('\$');
    if (parts.length != 2) return false;
    final salt = parts[0];
    final hash = parts[1];
    final bytes = utf8.encode(salt + text);
    final newHash = sha256.convert(bytes).toString();
    return newHash == hash;
  }

  static String _generateSalt([int length = 16]) {
    final random = Random.secure();
    final values = List<int>.generate(length, (i) => random.nextInt(256));
    return base64Url.encode(values);
  }
}