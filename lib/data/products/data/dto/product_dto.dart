import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_dto.g.dart';
part 'product_dto.freezed.dart';

/// `ProductDTO` is a makeup product's model response from remote. Containing:
///
/// - [int] id [required]
/// - [String] brand [required]
/// - [String] name [required]
/// - [String] price [required],
/// - [String] description [required],
/// - [String] imageLink [required]
/// - [String] productType [required]
/// - [String] productApiUrl [required],
/// - [List] of [ProductColorDTO] productColors [required],
/// - [DateTime] createdAt [required],
/// - [DateTime] updatedAt [required],
/// - [int] qty,
/// - [String] priceSign,
/// - [String] category,
@freezed
class ProductDTO with _$ProductDTO {
  const factory ProductDTO({
    required int id,
    required String brand,
    required String name,
    required String price,
    required String description,
    int? qty,
    String? priceSign,
    String? category,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'image_link') required String imageLink,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'product_type') required String productType,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'product_api_url') required String productApiUrl,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'product_colors')
        required List<ProductColorDTO> productColors,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'created_at') required DateTime createdAt,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _ProductDTO;

  factory ProductDTO.fromJson(Map<String, dynamic> json) =>
      _$ProductDTOFromJson(json);
}

/// `ProductColorDTO`is a makeup color list model response from remote. Containing:
///
/// - [String] hexValue [required]
/// - [String] colourName
@freezed
class ProductColorDTO with _$ProductColorDTO {
  const factory ProductColorDTO({
    // ignore: invalid_annotation_target
    @JsonKey(name: 'hex_value') required String hexValue,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'colour_name') String? colourName,
  }) = _ProductColor;

  factory ProductColorDTO.fromJson(Map<String, dynamic> json) =>
      _$ProductColorDTOFromJson(json);
}
