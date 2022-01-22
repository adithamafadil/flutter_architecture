import 'package:flutter_architecture/data/cart/domain/repositories/cart_repository.dart';
import 'package:flutter_architecture/data/cart/domain/usecases/get_cart_usecase.dart';
import 'package:flutter_architecture/data/products/domain/entites/product.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SetCartUsecase {
  final CartRepository _repository;
  final GetCartUsecase _getCartUsecase;
  const SetCartUsecase(this._repository, this._getCartUsecase);

  Future<bool> call(Product product) {
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

    return _repository.setCart(cart);
  }
}
