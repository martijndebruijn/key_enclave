import 'dart:async';

import 'package:flutter/services.dart';

class KeyEnclave {
  static const MethodChannel _channel = const MethodChannel('key_enclave');

  /// Generate Keypair (EC 256 bit)
  /// In ios store private key in Secure Enclave
  /// In Android in KeyStore
  /// return public key x509 format
  Future<String> generateKeyPair(String tag) async {
    final String pubicKey =
        await _channel.invokeMethod('generateKeyPair', {"TAG": tag});

    return "-----BEGIN PUBLIC KEY-----\n" +
        pubicKey +
        "\n-----END PUBLIC KEY-----";
  }

  Future<bool> deletePrivateKeyIfExist(String tag) async {
    final String deletCode =
        await _channel.invokeMethod('deleteKey', {"TAG": tag});
  }

  Future<String> signMessage(String tag, String message) async {
    final String signed = await _channel.invokeMethod("sign", {
      "TAG": tag,
      "MESSAGE": message,
    });

    return signed;
  }
}