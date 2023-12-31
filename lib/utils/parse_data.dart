// ignore_for_file: avoid_print

import 'package:homeowners_and_neighborhoods/utils/dot_calculator.dart';

ParsedData parseData(String inputData) {
  List<List<int>> setN = [];
  List<List<int>> setH = [];

  final lines = inputData.split('\n');

  for (int i = 0; i < lines.length; i++) {
    final line = lines[i].trim(); // Remove leading and trailing spaces

    if (line.isNotEmpty) {
      // Skip empty lines
      final parts = line.split(' ');

      if (parts[0] == 'N') {
        // Parse neighborhood data
        List<int> neighborhoodData = [];

        for (int j = 1; j < parts.length; j++) {
          final numPart = parts[j].split(':').last;
          final num = int.tryParse(numPart) ?? 0;
          neighborhoodData.add(num);
        }

        setN.add(neighborhoodData);
      } else if (parts[0] == 'H') {
        // Parse homeowner data
        List<int> homeownerData = [];

        for (int j = 1; j < parts.length - 1; j++) {
          final numPart = parts[j].split(':').last;
          final num = int.tryParse(numPart) ?? 0;
          homeownerData.add(num);
        }

        setH.add(homeownerData);
      }
    }
  }

  return ParsedData(setN, setH);
}

List<String> extractPreferences(String inputData) {
  List<String> preferences = [];

  final lines = inputData.split('\n');

  for (int i = 0; i < lines.length; i++) {
    final line = lines[i].trim(); // Remove leading and trailing spaces

    if (line.isNotEmpty && line.startsWith('H')) {
      final preference = line.substring(line.indexOf('N'));
      preferences.add(preference);
    }
  }

  return preferences;
}

String printDotProducts(String inputData) {
  final ParsedData parsedData = parseData(inputData);
  final List<List<int>> setN = parsedData.setN;
  final List<List<int>> setH = parsedData.setH;
  final List<String> preferences = extractPreferences(inputData);

  String output = ''; // Initialize an empty string to store the processed data

  for (int i = 0; i < setN.length; i++) {
    for (int j = 0; j < setH.length; j++) {
      try {
        int result = calculateDotProduct(setN[i], setH[j]);
        String preference = preferences[j];
        String line = "Dot Product for N$i and H$j $result $preference";
        print(
            line); // Print the line if you still want to see it in the console
        output += '$line\n'; // Add the line to the output string
      } catch (e) {
        print(e.toString());
      }
    }
  }

  return output; // Return the processed data as a string
}
