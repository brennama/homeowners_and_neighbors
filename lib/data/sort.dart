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

void main() {
  //update this to be data read from file,
  String input = """
    Dot Product for N0 and H6 188 N2>N1>N0
Dot Product for N0 and H3 171 N2>N0>N1
Dot Product for N0 and H5 161 N0>N2>N1
Dot Product for N0 and H11 154 N0>N1>N2
Dot Product for N0 and H2 128 N0>N2>N1
Dot Product for N2 and H6 128 N2>N1>N0
Dot Product for N0 and H4 122 N0>N2>N1
Dot Product for N2 and H3 120 N2>N0>N1
Dot Product for N0 and H10 120 N0>N2>N1
Dot Product for N0 and H1 119 N0>N2>N1
Dot Product for N2 and H5 112 N0>N2>N1
Dot Product for N2 and H11 108 N0>N1>N2
Dot Product for N0 and H7 106 N2>N1>N0
Dot Product for N2 and H4 106 N0>N2>N1
Dot Product for N0 and H0 104 N2>N0>N1
Dot Product for N0 and H8 100 N1>N0>N2
Dot Product for N0 and H9 94 N1>N2>N0
Dot Product for N2 and H9 86 N1>N2>N0
Dot Product for N2 and H10 86 N0>N2>N1
Dot Product for N2 and H0 83 N2>N0>N1
Dot Product for N2 and H8 80 N1>N0>N2
Dot Product for N2 and H7 75 N2>N1>N0
Dot Product for N2 and H1 74 N0>N2>N1
Dot Product for N2 and H2 68 N0>N2>N1
Dot Product for N1 and H6 31 N2>N1>N0
Dot Product for N1 and H3 31 N2>N0>N1
Dot Product for N1 and H11 27 N0>N1>N2
Dot Product for N1 and H5 26 N0>N2>N1
Dot Product for N1 and H4 23 N0>N2>N1
Dot Product for N1 and H9 23 N1>N2>N0
Dot Product for N1 and H8 21 N1>N0>N2
Dot Product for N1 and H10 21 N0>N2>N1
Dot Product for N1 and H7 20 N2>N1>N0
Dot Product for N1 and H1 18 N0>N2>N1
Dot Product for N1 and H2 18 N0>N2>N1
Dot Product for N1 and H0 17 N2>N0>N1
  """;

  List<DotProductData> data = parseDotProductData(input);

  //update this to not be hard coded but instead be number of homeowners divided by number of neighborhoods
  double maxHomeowners = 12 / 3;

  // Sort the data list by the highest dot product number
  data.sort((a, b) => b.dotProduct.compareTo(a.dotProduct));

  // Loop through the sorted data and assign homeowners to neighborhoods
  for (int i = 0; i < data.length; i++) {
    String homeowner = data[i].homeowner;
    String neighborhood = data[i].neighborhood;

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
      result.add('$neighborhood $homeowner');
      print('$homeowner has been assigned to $neighborhood');
    } else if (data[i].neighborhood == data[i].preferences[1]) {
      // Check if the preferred neighborhood has reached its limit, in which case assign to the second preference
      int preferredNeighborhoodCount =
          result.where((item) => item.contains(data[i].preferences[0])).length;
      if (preferredNeighborhoodCount >= maxHomeowners) {
        result.add('$neighborhood $homeowner');
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
        result.add('$neighborhood $homeowner');
        print('$homeowner has been assigned to $neighborhood');
      }
    }
  }
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
