import 'dart:convert';

import 'package:flutter_architecture/data/products/dto/product_dto.dart';
import 'package:flutter_architecture/data/products/mapper/product_mapper.dart';
import 'package:flutter_architecture/domain/products/entites/product.dart';

import '../helpers/read_json.dart';

class DummyData {
  static ProductDummyData get product => ProductDummyData();
}

class ProductDummyData {
  final ProductMapper _mapper = ProductMapper();

  String get stringDummyData => readJson('dummy_data/json/products_dummy.json');

  dynamic get mapDummyData => json.decode(stringDummyData);

  List<ProductDTO> get dtoDummyData =>
      List<ProductDTO>.from(mapDummyData.map((e) => ProductDTO.fromJson(e)));

  List<Product> get productDummyData =>
      dtoDummyData.map((e) => _mapper.mapProductDTOtoEntity(e)).toList();
}
