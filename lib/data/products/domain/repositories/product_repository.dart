import 'package:flutter_architecture/data/products/domain/entites/product.dart';
import 'package:flutter_architecture/state/remote/remote_state.dart';

abstract class ProductRepository {
  Future<RemoteState<List<Product>>> getProducts();
}
