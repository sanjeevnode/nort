import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';

class SecureHash {
  // Generate a random salt
  static String _generateSalt([int length = 16]) {
    final random = Random.secure();
    final saltBytes = List<int>.generate(length, (_) => random.nextInt(256));
    return base64Url.encode(saltBytes);
  }

  // Generate a SHA-256 hash with salt
  static Map<String, String> generate(String text) {
    final salt = _generateSalt();
    final hash = sha256.convert(utf8.encode(salt + text)).toString();
    return {
      'salt': salt,
      'hash': hash,
    };
  }

  static String generateHashWithSalt(String text, String salt) {
    final hash = sha256.convert(utf8.encode(salt + text)).toString();
    return hash;
  }

  // Compare text with hash using the stored salt
  static bool compare(String text, String salt, String hash) {
    final newHash = sha256.convert(utf8.encode(salt + text)).toString();
    return newHash == hash;
  }
}
