// ignore_for_file: avoid_print

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
  List<int> list1 = [7, 7, 10];
  List<int> list2 = [6, 7, 7];

  try {
    int result = calculateDotProduct(list1, list2);
    print("Dot Product: $result");
  } catch (e) {
    print(e.toString());
  }
}
