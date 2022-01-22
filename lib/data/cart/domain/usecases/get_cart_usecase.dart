import 'package:flutter_architecture/data/cart/domain/entities/cart.dart';
import 'package:flutter_architecture/data/cart/domain/repositories/cart_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetCartUsecase {
  final CartRepository _repository;
  const GetCartUsecase(this._repository);

  Cart call() => _repository.getCart();
}
