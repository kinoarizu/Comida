import 'package:get_storage/get_storage.dart';

/// Manage utility function for data local storage.

class StorageUtil {
  static GetStorage _box = GetStorage();

  static String readStorage(String key) {
    return _box.read(key);
  }

  static bool hasStorage(String key) {
    return _box.hasData(key);
  }

  static void writeStorage(String key, String value) {
    _box.write(key, value);
  }

  static void removeStorage(String key) {
    _box.remove(key);
  }
}