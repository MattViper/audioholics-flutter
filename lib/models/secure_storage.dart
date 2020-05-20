import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageMixin {
  final secureStore = new FlutterSecureStorage();

  void setSecureStorage(String key, String data) async {
    await secureStore.write(key: key, value: data);
  }

  void getSecureStorage(String key, Function callback) async {
    await secureStore.read(key: key).then(callback);
  }
}
