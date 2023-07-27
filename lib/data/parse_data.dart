import 'package:homeowners_and_neighborhoods/dot_calculator.dart';

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

void printDotProducts(String inputData) {
  final ParsedData parsedData = parseData(inputData);
  final List<List<int>> setN = parsedData.setN;
  final List<List<int>> setH = parsedData.setH;
  final List<String> preferences = extractPreferences(inputData);

  for (int i = 0; i < setN.length; i++) {
    for (int j = 0; j < setH.length; j++) {
      try {
        int result = calculateDotProduct(setN[i], setH[j]);
        String preference =
            preferences[j] ?? ''; // Use empty string if preference is null
        print("Dot Product for N$i and H$j $result $preference");
      } catch (e) {
        print(e.toString());
      }
    }
  }
}
