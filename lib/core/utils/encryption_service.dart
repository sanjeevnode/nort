import 'dart:convert';
import 'dart:developer';
import 'dart:math' hide log;
import 'dart:typed_data';
import 'package:cryptography/cryptography.dart';

class EncryptionService {
  // Static constants to avoid repeated instantiation
  static final _algorithm = AesGcm.with256bits();
  static const _nonceLength = 12; // AES-GCM standard nonce length
  static const _macLength = 16; // GCM MAC length is 16 bytes

  // Argon2 parameters - made configurable but with reasonable defaults
  static const _defaultMemory = 65536; // 64MB
  static const _defaultIterations = 3;
  static const _defaultParallelism = 1;
  static const _keyLength = 32; // 32 bytes for AES-256

  // Generate a key using Argon2 and return it as a Base64-encoded string
  static Future<String> generateKey(
    String password,
    String salt, {
    int memory = _defaultMemory,
    int iterations = _defaultIterations,
    int parallelism = _defaultParallelism,
  }) async {
    try {
      // Use the Argon2id algorithm (more secure than pure Argon2)
      final argon2 = Argon2id(
        memory: memory,
        iterations: iterations,
        parallelism: parallelism,
        hashLength: _keyLength,
      );

      // Generate key
      final derivedKey = await argon2.deriveKey(
        secretKey: SecretKey(utf8.encode(password)),
        nonce: utf8.encode(salt),
      );

      final keyBytes = await derivedKey.extractBytes();
      return base64.encode(keyBytes);
    } catch (e) {
      throw Exception('Key generation failed: ${e.toString()}');
    }
  }

  // Encrypt text using AES-256-GCM
  static Future<String> encryptText(String plaintext, String base64Key) async {
    try {
      final keyData = base64.decode(base64Key);
      final secretKey = SecretKey(keyData);

      // Encrypt in one call with automatically generated nonce
      final secretBox = await _algorithm.encrypt(
        utf8.encode(plaintext),
        secretKey: secretKey,
      );

      // Combine nonce, ciphertext and MAC more efficiently
      final combined =
          Uint8List(_nonceLength + secretBox.cipherText.length + _macLength);
      combined.setAll(0, secretBox.nonce);
      combined.setAll(_nonceLength, secretBox.cipherText);
      combined.setAll(
          _nonceLength + secretBox.cipherText.length, secretBox.mac.bytes);

      return base64.encode(combined);
    } catch (e) {
      throw Exception('Encryption failed: ${e.toString()}');
    }
  }

  // Decrypt text using AES-256-GCM
  static Future<String> decryptText(
      String encryptedBase64, String base64Key) async {
    try {
      final keyData = base64.decode(base64Key);
      final combined = base64.decode(encryptedBase64);

      if (combined.length < _nonceLength + _macLength) {
        throw const FormatException('Invalid encrypted data format');
      }

      // Extract components more efficiently
      final nonce = combined.sublist(0, _nonceLength);
      final cipherText =
          combined.sublist(_nonceLength, combined.length - _macLength);
      final macBytes = combined.sublist(combined.length - _macLength);

      // Create a SecretBox with the extracted components
      final secretBox = SecretBox(
        cipherText,
        nonce: nonce,
        mac: Mac(macBytes),
      );

      // Decrypt
      final plainTextBytes = await _algorithm.decrypt(
        secretBox,
        secretKey: SecretKey(keyData),
      );

      return utf8.decode(plainTextBytes);
    } catch (e) {
      throw Exception('Decryption failed: ${e.toString()}');
    }
  }

  // Add a utility method to generate a secure random salt
  static Future<String> generateSalt([int length = 16]) async {
    // Use a secure random generator directly instead of newNonce with custom length
    final secureRandom = Random.secure();
    final bytes = List<int>.generate(length, (_) => secureRandom.nextInt(256));
    return base64.encode(bytes);
  }

  static Future<void> test() async {
    const password = 'Sanjeev';
    final salt = await generateSalt();
    log('Password: $password');
    log('Salt: $salt');
    final key = await generateKey(password, salt);
    log('Key 1: $key ');
    final encrypted = await encryptText('Hello, World!', key);
    log('Encrypted: $encrypted');
    final key2 = await generateKey(password, salt);
    log('Key 2: $key2');
    final decrypted = await decryptText(encrypted, key2);
    log('Decrypted: $decrypted');
  }
}
