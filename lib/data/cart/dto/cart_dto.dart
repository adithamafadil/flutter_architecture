import 'package:flutter_architecture/data/products/dto/product_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'cart_dto.freezed.dart';
part 'cart_dto.g.dart';

@freezed
class CartDTO with _$CartDTO {
  const factory CartDTO({
    required List<ProductDTO> products,
  }) = _CartDTO;

  factory CartDTO.fromJson(Map<String, dynamic> json) =>
      _$CartDTOFromJson(json);
}
