import 'package:flutter_architecture/data/cart/domain/entities/cart.dart';

abstract class CartRepository {
  Cart getCart();
  Future<bool> setCart(Cart cart);
  Future<bool> deleteCart();
}
