import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class DataStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _inputFile async {
    final path = await _localPath;
    return File('$path/input.txt');
  }

  Future<File> get _outputFile async {
    final path = await _localPath;
    return File('$path/output.txt');
  }

  Future<String> readInput() async {
    try {
      final file = await _inputFile;
      final contents = await file.readAsString();
      return contents;
    } catch (e) {
      return '';
    }
  }

  Future<String> readOutput() async {
    try {
      final file = await _outputFile;
      final contents = await file.readAsString();
      return contents;
    } catch (e) {
      return '';
    }
  }

  Future<File> writeInput(String data) async {
    final file = await _inputFile;
    return file.writeAsString(data);
  }

  Future<File> writeOutput(String data) async {
    final file = await _outputFile;
    return file.writeAsString(data);
  }
}
