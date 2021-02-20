import 'package:flutter_string_encryption/flutter_string_encryption.dart';

class Decryptor {
  static final cryptor = new PlatformStringCryptor();
  static final password =
      "aMHp7UwTeAUf7JYTi+Opcg==:aOTvlL2z6iP/2DPczLdBr0jJMp1bmIOO6Cp9LMcr5jQ=";
  static var prefix = "treasuresofra://base=";

  static Future<String> encrypt(String s) async {
    final String encrypted = await cryptor.encrypt(s, password);
    print("ENCRYOTED_DO_NOT_USE_THIS_VALUE_FOR_FB: $encrypted");
    print("ENCRYOTED_FOR_FB!!!: ${encrypted.replaceAll("=", ".").replaceAll(":", ",")}");
    return encrypted.replaceAll("=", ".").replaceAll(":", ",");
  }

  static Future<String> decrypt(String encrypted) async {
    if (encrypted != null) {
      encrypted = encrypted.replaceAll(".", "=").replaceAll(",", ":");
      if (encrypted.contains(prefix))
        encrypted = encrypted.replaceRange(0, prefix.length, '');
      if (encrypted.contains("?al_applink_data"))
        encrypted = encrypted.replaceRange(
            encrypted.indexOf('?al_applink_data'), encrypted.length, '');

      try {
        final String decrypted = await cryptor.decrypt(encrypted, password);
        print("DECRYPTED: $decrypted");
        return decrypted;
      } on MacMismatchException {
        return '';
      }
    } else {
      return '';
    }
  }
}