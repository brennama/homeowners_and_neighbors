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
