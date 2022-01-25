import 'package:flutter_architecture/data/cart/domain/repositories/cart_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class RemoveProductAtUsecase {
  final CartRepository _repository;

  const RemoveProductAtUsecase(this._repository);

  void call(int index) => _repository.removeProductAt(index);
}
