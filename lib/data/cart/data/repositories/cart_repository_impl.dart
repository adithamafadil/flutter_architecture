import 'package:flutter_architecture/data/cart/data/mapper/cart_mapper.dart';
import 'package:flutter_architecture/data/cart/data/repositories/sources/local/cart_local_repository.dart';
import 'package:flutter_architecture/data/cart/domain/entities/cart.dart';
import 'package:flutter_architecture/data/cart/domain/repositories/cart_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: CartRepository)
class CartRepositoryImpl extends CartRepository {
  final CartLocalRepository _localRepository;
  final CartMapper _mapper;

  CartRepositoryImpl(this._localRepository, this._mapper);

  @override
  Cart getCart() => _mapper.mapCartDTOtoEntity(_localRepository.getCart());

  @override
  Future<bool> setCart(Cart cart) =>
      _localRepository.setCart(_mapper.mapCartEntityToDTO(cart));

  @override
  Future<bool> deleteCart() => _localRepository.deleteCart();

  @override
  void removeProductAt(int index) => _localRepository.removeProductAt(index);
}
