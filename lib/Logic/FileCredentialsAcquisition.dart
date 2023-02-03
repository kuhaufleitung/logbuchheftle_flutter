import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../Data/FileCredentials.dart';

class FileCredentialsAcquisition {
  final FileCredentials _fileCredentials;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  FileCredentialsAcquisition(this._fileCredentials);

  Future<void> readDataFromStorage() async {
    try {
      await _secureStorage
          .read(key: 'serverIp', aOptions: _getAndroidOptions())
          .then((value) => _fileCredentials.setServerAddress(value!));
      await _secureStorage
          .read(key: 'port', aOptions: _getAndroidOptions())
          .then((value) => _fileCredentials.setPort(value!));
      await _secureStorage
          .read(key: 'username', aOptions: _getAndroidOptions())
          .then((value) => _fileCredentials.setUsername(value!));
      await _secureStorage
          .read(key: 'password', aOptions: _getAndroidOptions())
          .then((value) => _fileCredentials.setPassword(value!));
    } catch (e) {
      print(e);
    }
  }

  void writeDataToStorage(String action) async {
    try {
      switch (action) {
        case "ip":
          await _secureStorage.write(
              key: 'serverIp',
              aOptions: _getAndroidOptions(),
              value: _fileCredentials.getServerAddress);
          break;
        case "port":
          await _secureStorage.write(
              key: 'port',
              aOptions: _getAndroidOptions(),
              value: _fileCredentials.getPort);
          break;
        case "username":
          await _secureStorage.write(
              key: 'username',
              aOptions: _getAndroidOptions(),
              value: _fileCredentials.getUsername);
          break;
        case "password":
          await _secureStorage.write(
              key: 'password',
              aOptions: _getAndroidOptions(),
              value: _fileCredentials.getPassword);
          break;
      }
    } catch (e) {
      print(e);
    }
  }

  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );
}
