import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:homeowners_and_neighborhoods/utils/data_storage.dart';

void main() {
  group('DataStorage', () {
    test('writeInput and readInput', () async {
      // Create a temporary directory for testing
      final Directory tempDir = await Directory.systemTemp.createTemp();
      final String tempPath = tempDir.path;
      final DataStorage dataStorage = DataStorage(tempPath);

      // Test data to be written to the input file
      const String testData = 'This is a test input data';

      // Write data to the input file
      await dataStorage.writeInput(testData);

      // Read data from the input file
      final String readData = await dataStorage.readInput();

      // Assert that the read data matches the test data
      expect(readData, testData);

      // Cleanup: Delete the temporary directory
      await tempDir.delete(recursive: true);
    });
  });
  group('DataStorage', () {
    test('writeOutput and readOutput', () async {
      // Create a temporary directory for testing
      final Directory tempDir = await Directory.systemTemp.createTemp();
      final String tempPath = tempDir.path;
      final DataStorage dataStorage = DataStorage(tempPath);

      // Test data to be written to the output file
      const String testData = 'This is a test output data';

      // Write data to the output file
      await dataStorage.writeOutput(testData);

      // Read data from the output file
      final String readData = await dataStorage.readOutput();

      // Assert that the read data matches the test data
      expect(readData, testData);

      // Cleanup: Delete the temporary directory
      await tempDir.delete(recursive: true);
    });
  });
}
