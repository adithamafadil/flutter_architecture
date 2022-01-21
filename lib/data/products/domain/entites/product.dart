import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final int id;
  final String brand;
  final String name;
  final String price;
  final String description;
  final int? qty;
  final String? priceSign;
  final String? category;
  final String imageLink;
  final String productType;
  final String productApiUrl;
  final List<ProductColor> productColors;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Product({
    required this.id,
    required this.brand,
    required this.name,
    required this.price,
    required this.description,
    this.qty,
    this.priceSign,
    this.category,
    required this.imageLink,
    required this.productType,
    required this.productApiUrl,
    required this.productColors,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        brand,
        name,
        price,
        description,
        qty,
        priceSign,
        category,
        imageLink,
        productType,
        productApiUrl,
        productColors,
        createdAt,
        updatedAt,
      ];
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
