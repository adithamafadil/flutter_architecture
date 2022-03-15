import 'package:flutter_architecture/data/cart/mapper/cart_mapper.dart';
import 'package:flutter_architecture/data/cart/repositories/sources/local/cart_local_repository.dart';
import 'package:flutter_architecture/domain/cart/entities/cart.dart';
import 'package:flutter_architecture/domain/cart/repositories/cart_repository.dart';
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
