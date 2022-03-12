import 'package:bonapptest/provider/sub_category_provider.dart';

class SubCategoryModel {
  final int id;
  final String productName;
  final String image;
  final int price;
  final Products product;

  SubCategoryModel({
    required this.id,
    required this.productName,
    required this.image,
    required this.price,
    required this.product,
  });
}
