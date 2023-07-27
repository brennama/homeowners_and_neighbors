import 'data_storage.dart';

class DotProductData {
  final String neighborhood;
  final String homeowner;
  final int dotProduct;
  final List<String> preferences;

  DotProductData({
    required this.neighborhood,
    required this.homeowner,
    required this.dotProduct,
    required this.preferences,
  });
}

final List<String> result = [];

//update this to be data read from file,

String assignHomeowners(String input, double maxHomeowners) {
  result.clear(); // Clear the result list at the beginning of the function

  if (input.isEmpty) {
    // If input data is empty, return empty output
    return '';
  }

  List<DotProductData> data = parseDotProductData(input);

  // Sort the data list by the highest dot product number
  data.sort((a, b) => b.dotProduct.compareTo(a.dotProduct));

  // Loop through the sorted data and assign homeowners to neighborhoods
  for (int i = 0; i < data.length; i++) {
    String homeowner = data[i].homeowner;
    String neighborhood = data[i].neighborhood;
    int dotProduct = data[i].dotProduct; // Get the dot product score

    // Check if the homeowner is already present in the 'result' list
    bool homeownerAlreadyAssigned =
        result.any((item) => item.split(' ')[1] == homeowner);

    // Check if the neighborhood is already at its limit in the 'result' list
    bool neighborhoodFull =
        result.where((item) => item.contains(neighborhood)).length >=
            maxHomeowners;

    if (homeownerAlreadyAssigned || neighborhoodFull) {
      continue; // Skip assigning this homeowner if already assigned or if the neighborhood is full
    }

    // If the homeowner's preference matches the neighborhood and it satisfies the conditions, add them to the 'result' list
    if (data[i].neighborhood == data[i].preferences[0]) {
      result.add('$neighborhood $homeowner $dotProduct');
      print('$homeowner has been assigned to $neighborhood');
    } else if (data[i].neighborhood == data[i].preferences[1]) {
      // Check if the preferred neighborhood has reached its limit, in which case assign to the second preference
      int preferredNeighborhoodCount =
          result.where((item) => item.contains(data[i].preferences[0])).length;
      if (preferredNeighborhoodCount >= maxHomeowners) {
        result.add('$neighborhood $homeowner $dotProduct');
        print('$homeowner has been assigned to $neighborhood');
      }
    } else if (data[i].neighborhood == data[i].preferences[2]) {
      // Check if the second preference neighborhood has reached its limit, in which case assign to the third preference
      int preferredNeighborhoodCount =
          result.where((item) => item.contains(data[i].preferences[0])).length;
      int secondPreferenceCount =
          result.where((item) => item.contains(data[i].preferences[1])).length;
      if (preferredNeighborhoodCount >= maxHomeowners &&
          secondPreferenceCount >= maxHomeowners) {
        result.add('$neighborhood $homeowner $dotProduct');
        print('$homeowner has been assigned to $neighborhood');
      }
    }
  }
  return formatResults();
}

List<DotProductData> parseDotProductData(String input) {
  List<DotProductData> result = [];
  final lines = input.split('\n');

  for (int i = 0; i < lines.length; i++) {
    final line = lines[i].trim(); // Remove leading and trailing spaces

    if (line.isNotEmpty) {
      // Skip empty lines
      final parts = line.split(' ');

      if (parts.length >= 8 &&
          parts[0] == 'Dot' &&
          parts[1] == 'Product' &&
          parts[2] == 'for') {
        final neighborhood = parts[3];
        final homeowner = parts[5];
        final dotProduct = int.tryParse(parts[6]) ?? 0;
        final preferences =
            parts.sublist(7).join(' ').split('>').map((e) => e.trim()).toList();

        result.add(
          DotProductData(
            neighborhood: neighborhood,
            homeowner: homeowner,
            dotProduct: dotProduct,
            preferences: preferences,
          ),
        );
      }
    }
  }

  return result;
}

String formatResults() {
  final Map<String, List<String>> neighborhoodsMap = {};

  result.sort((a, b) {
    final aNeighborhood = a.split(' ')[0];
    final bNeighborhood = b.split(' ')[0];
    return aNeighborhood.compareTo(bNeighborhood);
  });

  for (var assignment in result) {
    final parts = assignment.split(' ');
    final neighborhood = parts[0];
    final homeowner = parts[1];
    final dotProduct = parts[2];

    neighborhoodsMap
        .putIfAbsent(neighborhood, () => [])
        .add('$homeowner($dotProduct)');
  }

  String formattedOutput = '';
  for (var entry in neighborhoodsMap.entries) {
    final neighborhood = entry.key;
    final homeowners = entry.value.join(' ');
    formattedOutput += '$neighborhood: $homeowners\n';
  }

  return formattedOutput;
}
