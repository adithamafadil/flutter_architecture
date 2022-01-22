import 'dart:convert';

import 'package:flutter_architecture/constants/constants.dart';
import 'package:flutter_architecture/data/cart/data/dto/cart_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@lazySingleton
class CartLocalRepository {
  final SharedPreferences _sharedPreferences;

  const CartLocalRepository(this._sharedPreferences);

  CartDTO getCart() {
    final jsonCartString =
        _sharedPreferences.getString(MyConstants.cachedKey.cartCachedKey);

    if (jsonCartString != null) {
      return CartDTO.fromJson(json.decode(jsonCartString));
    }

    return const CartDTO(products: []);
  }

  Future<bool> setCart(CartDTO cart) async {
    return await _sharedPreferences.setString(
      MyConstants.cachedKey.cartCachedKey,
      json.encode(cart.toJson()),
    );
  }

  Future<bool> deleteCart() async =>
      await _sharedPreferences.remove(MyConstants.cachedKey.cartCachedKey);
}
