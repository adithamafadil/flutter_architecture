import 'package:injectable/injectable.dart';
import 'package:flutter_architecture/data/products/data/dto/product_dto.dart';
import 'package:flutter_architecture/data/products/domain/entites/product.dart';

@lazySingleton
class ProductMapper {
  ProductDTO mapProductEntityToDTO(Product product) {
    List<ProductColorDTO> colors = [];
    for (var color in product.productColors) {
      colors.add(mapProductColorEntityToDTO(color));
    }

    return ProductDTO(
      id: product.id,
      brand: product.brand,
      name: product.name,
      price: product.price,
      description: product.description,
      imageLink: product.imageLink,
      productType: product.productType,
      productApiUrl: product.productApiUrl,
      productColors: colors,
      createdAt: product.createdAt,
      updatedAt: product.updatedAt,
      category: product.category,
      priceSign: product.priceSign,
      qty: product.qty,
    );
  }

  ProductColorDTO mapProductColorEntityToDTO(ProductColor color) {
    return ProductColorDTO(
      hexValue: color.hexValue,
      colourName: color.colourName,
    );
  }

  Product mapProductDTOtoEntity(ProductDTO product) {
    List<ProductColor> colors = [];
    for (var color in product.productColors) {
      colors.add(mapProductColorDTOtoEntity(color));
    }

    return Product(
      id: product.id,
      brand: product.brand,
      name: product.name,
      price: product.price,
      description: product.description,
      imageLink: product.imageLink,
      productType: product.productType,
      productApiUrl: product.productApiUrl,
      productColors: colors,
      createdAt: product.createdAt,
      updatedAt: product.updatedAt,
      category: product.category,
      priceSign: product.priceSign,
      qty: product.qty ?? 1,
    );
  }

  ProductColor mapProductColorDTOtoEntity(ProductColorDTO color) {
    return ProductColor(
      hexValue: color.hexValue,
      colourName: color.colourName,
    );
  }
}
