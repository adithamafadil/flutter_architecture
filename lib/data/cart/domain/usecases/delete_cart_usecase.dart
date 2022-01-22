import 'package:flutter_architecture/data/cart/domain/repositories/cart_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class DeleteCartUsecase {
  final CartRepository _repository;

  const DeleteCartUsecase(this._repository);

  Future<bool> call() => _repository.deleteCart();
}
