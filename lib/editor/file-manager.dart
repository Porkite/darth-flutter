import 'dart:io';

class FileManager {
  static final FileManager _instance = FileManager._internal();
  late String currentFilePath;

  factory FileManager() {
    return _instance;
  }

  saveFile(String data) async {
    try {
      File file = File(currentFilePath);
      await file.writeAsString(data);
    } catch (e) {
      print('Wystąpił błąd podczas zapisu pliku: $e');
    }
  }

  setCurrentFilePath(String path) {
    currentFilePath = path;
  }

  FileManager._internal();
}