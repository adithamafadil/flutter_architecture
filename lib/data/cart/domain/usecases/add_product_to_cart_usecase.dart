import 'package:flutter_architecture/data/cart/domain/repositories/cart_repository.dart';
import 'package:flutter_architecture/data/cart/domain/usecases/get_cart_usecase.dart';
import 'package:flutter_architecture/data/products/domain/entites/product.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AddProductToCart {
  final CartRepository _repository;
  final GetCartUsecase _getCartUsecase;
  const AddProductToCart(this._repository, this._getCartUsecase);

  Future<bool> call(Product product) async {
    final cart = _getCartUsecase.call();

    if (cart.products.any((element) => element.id == product.id)) {
      for (Product element in cart.products) {
        if (element.id == product.id) {
          element.qty = element.qty + 1;
        }
      }
    } else {
      cart.products.add(product);
    }

    return await _repository.setCart(cart);
  }
}
