// ignore_for_file: avoid_print

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

void main() {
  String input = """
    Dot Product for N0 and H6: 188 N2>N1>N0
    Dot Product for N0 and H3: 171 N2>N0>N1
    Dot Product for N0 and H5: 161 N0>N2>N1
    Dot Product for N0 and H11: 154 N0>N1>N2
    // Add the rest of the data here...
  """;

  List<DotProductData> data = parseDotProductData(input);

  // Print the parsed DotProductData objects
  for (int i = 0; i < data.length; i++) {
    print('Neighborhood: ${data[i].neighborhood}');
    print('Homeowner: ${data[i].homeowner}');
    print('Dot Product: ${data[i].dotProduct}');
    print('Preferences: ${data[i].preferences}');
    print('-------------------------');
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
