import 'package:flutter_architecture/domain/cart/repositories/cart_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class DeleteCartUsecase {
  final CartRepository _repository;

  const DeleteCartUsecase(this._repository);

  Future<bool> call() => _repository.deleteCart();
}
