import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../Data/FileCredentials.dart';

class FileCredentialsAcquisition {
  final FileCredentials _fileCredentials;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  FileCredentialsAcquisition(this._fileCredentials);

  Future<void> readDataFromStorage() async {
    try {
      String? serverAddress = await _secureStorage.read(
          key: 'serverIp', aOptions: _getAndroidOptions());
      String? port = await _secureStorage.read(
          key: 'port', aOptions: _getAndroidOptions());
      String? username = await _secureStorage
          .read(key: 'username', aOptions: _getAndroidOptions());
      String? password = await _secureStorage
          .read(key: 'password', aOptions: _getAndroidOptions());
      _fileCredentials.setServerAddress(serverAddress!);
      _fileCredentials.setPort(port!);
      _fileCredentials.setUsername(username!);
      _fileCredentials.setPassword(password!);
    } catch (e) {
      print(e);
    }
  }

  void writeAllDataToStorage() async {
    await _secureStorage.write(
        key: 'serverIp',
        aOptions: _getAndroidOptions(),
        value: _fileCredentials.getServerAddress);
    await _secureStorage.write(
        key: 'port',
        aOptions: _getAndroidOptions(),
        value: _fileCredentials.getPort);
    await _secureStorage.write(
        key: 'username',
        aOptions: _getAndroidOptions(),
        value: _fileCredentials.getUsername);
    await _secureStorage.write(
        key: 'password',
        aOptions: _getAndroidOptions(),
        value: _fileCredentials.getPassword);
  }

  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  void writeJWTToStorage() {}
}
