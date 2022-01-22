import 'package:flutter_architecture/data/cart/domain/repositories/cart_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetTotalCart {
  final CartRepository _repository;

  const GetTotalCart(this._repository);

  int call() {
    final cart = _repository.getCart();
    int total = 0;

    for (var element in cart.products) {
      total += element.qty;
    }

    return total;
  }
}
