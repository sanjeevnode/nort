import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
class Hash {
  static String generate(String text) {
    final bytes = utf8.encode(text);
    final hash = sha256.convert(bytes);
    return hash.toString();
  }

  static bool compare(String text, String hash) {
    final bytes = utf8.encode(text);
    final newHash = sha256.convert(bytes).toString();
    return newHash == hash;
  }
}