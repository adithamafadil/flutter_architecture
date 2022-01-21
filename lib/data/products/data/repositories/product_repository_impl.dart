import 'package:injectable/injectable.dart';
import 'package:flutter_architecture/data/products/data/mapper/product_mapper.dart';
import 'package:flutter_architecture/data/products/data/repositories/sources/remote/product_remote_repository.dart';
import 'package:flutter_architecture/data/products/domain/entites/product.dart';
import 'package:flutter_architecture/data/products/domain/repositories/product_repository.dart';
import 'package:flutter_architecture/state/remote/remote_state.dart';

@LazySingleton(as: ProductRepository)
class ProductRepositoryImpl extends ProductRepository {
  final ProductRemoteRepository _remoteRepository;
  final ProductMapper _mapper;

  ProductRepositoryImpl(
    this._remoteRepository,
    this._mapper,
  );

  @override
  Future<RemoteState<List<Product>>> getProducts() async {
    final result = await _remoteRepository.getProducts();

    return result.when(
      success: (data) => RemoteState<List<Product>>.success(
          data: data.map((e) => _mapper.mapProductDTOtoEntity(e)).toList()),
      error: (message, data, statusCode, exception, stackTrace) =>
          RemoteState<List<Product>>.error(
        data: data?.map((e) => _mapper.mapProductDTOtoEntity(e)).toList(),
        statusCode: statusCode,
        message: message,
        exception: exception,
        stackTrace: stackTrace,
      ),
    );
  }
}
