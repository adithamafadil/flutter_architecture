import 'package:equatable/equatable.dart';
import 'package:flutter_architecture/data/products/domain/entites/product.dart';

class DetailArguments extends Equatable {
  final Product product;

  const DetailArguments({required this.product});

  @override
  List<Object?> get props => [product];
}
