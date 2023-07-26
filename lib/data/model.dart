class DotProductData {
  final String neighborhood;
  final String homeowner;
  final int dotProduct;
  final String preferences;

  DotProductData({
    required this.neighborhood,
    required this.homeowner,
    required this.dotProduct,
    required this.preferences,
  });
}

/*
import 'package:homeowners_and_neighborhoods/data/model.dart';

List<DotProductData> data = [
  DotProductData(
    neighborhood: 'N0',
    homeowner: 'H6',
    dotProduct: 188,
    preferences: 'N2>N1>N0',
  ),
  DotProductData(
    neighborhood: 'N0',
    homeowner: 'H3',
    dotProduct: 171,
    preferences: 'N2>N0>N1',
  ),
];
*/

List<DotProductData> data = [
  DotProductData(
    neighborhood: 'N0',
    homeowner: 'H6',
    dotProduct: 188,
    preferences: 'N2>N1>N0',
  ),
  DotProductData(
    neighborhood: 'N0',
    homeowner: 'H3',
    dotProduct: 171,
    preferences: 'N2>N0>N1',
  ),
  DotProductData(
    neighborhood: 'N0',
    homeowner: 'H5',
    dotProduct: 161,
    preferences: 'N0>N2>N1',
  ),
  DotProductData(
    neighborhood: 'N0',
    homeowner: 'H11',
    dotProduct: 154,
    preferences: 'N0>N1>N2',
  ),
  DotProductData(
    neighborhood: 'N0',
    homeowner: 'H2',
    dotProduct: 128,
    preferences: 'N0>N2>N1',
  ),
  DotProductData(
    neighborhood: 'N0',
    homeowner: 'H6',
    dotProduct: 128,
    preferences: 'N2>N1>N0',
  ),
  DotProductData(
    neighborhood: 'N0',
    homeowner: 'H4',
    dotProduct: 122,
    preferences: 'N0>N2>N1',
  ),
  DotProductData(
    neighborhood: 'N0',
    homeowner: 'H5',
    dotProduct: 161,
    preferences: 'N0>N2>N1',
  ),
];
