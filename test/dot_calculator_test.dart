import 'package:test/test.dart';

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
  test('Dot product of two lists', () {
    // Test case 1
    expect(calculateDotProduct([7, 7, 10], [6, 7, 7]), equals(161));

    // Test case 2
    expect(calculateDotProduct([2, 1, 1], [10, 2, 1]), equals(23));

    // Test case 3
    expect(calculateDotProduct([7, 6, 4], [8, 6, 9]), equals(128));

    // Test case 4 - Lists with different lengths, expect an ArgumentError
    expect(() => calculateDotProduct([1, 2, 3], [4, 5]), throwsArgumentError);
  });
}
