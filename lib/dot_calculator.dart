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

void main() {
  List<List<int>> setN = [
    [7, 7, 10],
    [2, 1, 1],
    [7, 6, 4],
  ];

  List<List<int>> setH = [
    [3, 9, 2],
    [4, 3, 7],
    [4, 0, 10],
    [10, 3, 8],
  ];

  for (int i = 0; i < setN.length; i++) {
    for (int j = 0; j < setH.length; j++) {
      try {
        int result = calculateDotProduct(setN[i], setH[j]);
        print("Dot Product for N$i and H$j $result");
      } catch (e) {
        print(e.toString());
      }
    }
  }
}
