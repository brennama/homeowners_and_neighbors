int calculateDotProduct(List<int> list1, List<int> list2) {
  if (list1.length != list2.length) {
    throw ArgumentError("The two lists must have the same length.");
  }

  int dotProduct = 0;
  for (int i = 0; i < list1.length; i++) {
    dotProduct += list1[i] * list2[i];
  }
  return dotProduct;
}

class ParsedData {
  final List<List<int>> setN;
  final List<List<int>> setH;

  ParsedData(this.setN, this.setH);
}

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

void main() {
  String inputData = """
  N N0 E:7 W:7 R:10
  N N1 E:2 W:1 R:1
  N N2 E:7 W:6 R:4
  H H0 E:3 W:9 R:2 N2>N0>N1
  H H1 E:4 W:3 R:7 N0>N2>N1
  H H2 E:4 W:0 R:10 N0>N2>N1
  H H3 E:10 W:3 R:8 N2>N0>N1
  H H4 E:6 W:10 R:1 N0>N2>N1
  H H5 E:6 W:7 R:7 N0>N2>N1
  H H6 E:8 W:6 R:9 N2>N1>N0
  H H7 E:7 W:1 R:5 N2>N1>N0
  H H8 E:8 W:2 R:3 N1>N0>N2
  H H9 E:10 W:2 R:1 N1>N2>N0
  H H10 E:6 W:4 R:5 N0>N2>N1
  H H11 E:8 W:4 R:7 N0>N1>N2
  """;

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
  // Just to verify, let's print the parsed data
  print("SetN: $setN");
  print("SetH: $setH");
}
