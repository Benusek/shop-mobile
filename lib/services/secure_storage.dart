import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final _storage = const FlutterSecureStorage();

  // Method to securely store data
  Future<void> writeSecureData(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  // Method to retrieve securely stored data
  Future<String?> readSecureData(String key) async {
    return await _storage.read(key: key);
  }

  // Method to delete specific data
  Future<void> deleteSecureData(String key) async {
    await _storage.delete(key: key);
  }

  // Method to delete all stored data (useful for logout)
  Future<void> deleteAllData() async {
    await _storage.deleteAll();
  }
}