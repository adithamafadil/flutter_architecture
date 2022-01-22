import 'package:equatable/equatable.dart';

class Product {
  int id;
  String brand;
  String name;
  String price;
  String description;
  int qty;
  String? priceSign;
  String? category;
  String imageLink;
  String productType;
  String productApiUrl;
  List<ProductColor> productColors;
  DateTime createdAt;
  DateTime updatedAt;

  Product({
    required this.id,
    required this.brand,
    required this.name,
    required this.price,
    required this.description,
    this.priceSign,
    this.category,
    this.qty = 1,
    required this.imageLink,
    required this.productType,
    required this.productApiUrl,
    required this.productColors,
    required this.createdAt,
    required this.updatedAt,
  });
}

class ProductColor extends Equatable {
  final String hexValue;
  final String? colourName;

  const ProductColor({
    required this.hexValue,
    this.colourName,
  });

  @override
  List<Object?> get props => [hexValue, colourName];
}
