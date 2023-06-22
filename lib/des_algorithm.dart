import 'package:flutter_des/flutter_des.dart';

class DESAlgorthm {
  static Future<String> encrypt(String plaintext, String key) async {
    return await FlutterDes.encryptToBase64(plaintext, padStringTo32Bytes(key));
  }

  static Future<String> decrypt(String ciphertext, String key) async {
    return (await FlutterDes.decryptFromBase64(
        ciphertext, padStringTo32Bytes(key)))!;
  }

  static String padStringTo32Bytes(String inputString) {
    const desiredLength = 32;
    final currentLength = inputString.length;

    if (currentLength >= desiredLength) {
      return inputString.substring(0, desiredLength);
    }

    final repetitions = (desiredLength / currentLength).ceil();
    final paddedString =
        inputString.padRight(repetitions * currentLength, inputString);

    return paddedString.substring(0, desiredLength);
  }
}
