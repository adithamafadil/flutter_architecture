import 'dart:async';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_architecture/constants/constants.dart';
import 'package:flutter_architecture/data/products/data/dto/product_dto.dart';
import 'package:flutter_architecture/state/remote/remote_state.dart';

@lazySingleton
class ProductRemoteRepository {
  final Dio _dio;
  const ProductRemoteRepository(this._dio);

  Future<RemoteState<List<ProductDTO>>> getProducts() async {
    try {
      final url = MyConstants.endpoint.product;

      final response = await _dio.get(url);

      if (response.statusCode == 200) {
        final listProducts = response.data;
        List<ProductDTO> listProductsDTO = List<ProductDTO>.from(
          listProducts.map((product) => ProductDTO.fromJson(product)),
        );

        return RemoteState<List<ProductDTO>>.success(data: listProductsDTO);
      } else {
        return RemoteState.error(
          statusCode: response.statusCode,
          message: response.statusMessage ?? 'Unhandled Error',
          stackTrace: StackTrace.current,
        );
      }
    } on DioError catch (e) {
      return RemoteState.error(
        exception: e,
        stackTrace: e.stackTrace,
        message: '${e.message}: ${e.response?.statusMessage}',
        statusCode: e.response?.statusCode ?? 808,
      );
    } on TimeoutException catch (e, stack) {
      return RemoteState.error(
        exception: e,
        stackTrace: stack,
        message: '${e.message}: Has been trying for ${e.duration}',
      );
    } on Exception catch (e, stack) {
      return RemoteState.error(
        message: 'Unhandled Error',
        exception: e,
        stackTrace: stack,
      );
    }
  }
}
