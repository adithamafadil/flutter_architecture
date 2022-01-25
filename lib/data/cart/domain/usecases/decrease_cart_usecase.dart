import 'package:flutter_architecture/data/cart/domain/repositories/cart_repository.dart';
import 'package:flutter_architecture/data/cart/domain/usecases/get_cart_usecase.dart';
import 'package:flutter_architecture/data/products/domain/entites/product.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class DecreaseCartUsecase {
  final CartRepository _repository;
  final GetCartUsecase _getCartUsecase;

  DecreaseCartUsecase(
    this._repository,
    this._getCartUsecase,
  );

  Future<bool> call(Product product) async {
    final cart = _getCartUsecase.call();

    if (cart.products.any((element) => element.id == product.id)) {
      for (Product element in cart.products) {
        if (element.id == product.id && element.qty > 1) {
          element.qty = element.qty - 1;
        }
      }
    }

    return await _repository.setCart(cart);
  }
}
