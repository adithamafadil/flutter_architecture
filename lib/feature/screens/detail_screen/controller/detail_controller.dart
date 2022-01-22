import 'package:flutter_architecture/data/cart/domain/entities/cart.dart';
import 'package:flutter_architecture/data/cart/domain/usecases/get_cart_usecase.dart';
import 'package:flutter_architecture/data/cart/domain/usecases/get_total_cart.dart';
import 'package:flutter_architecture/data/cart/domain/usecases/set_cart_usecase.dart';
import 'package:flutter_architecture/data/products/domain/entites/product.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';
import 'package:injectable/injectable.dart';

@injectable
class DetailController extends GetxController {
  final GetCartUsecase getCartUsecase;
  final GetTotalCart getTotalCart;
  final SetCartUsecase setCartUsecase;

  DetailController({
    required this.getCartUsecase,
    required this.getTotalCart,
    required this.setCartUsecase,
  });

  Rx<Cart> cart = Rx(Cart(products: []));
  RxInt totalCart = 0.obs;

  Future<void> addItemToCart(Product product) async {
    setCartUsecase.call(product);
    update();

    getCart();
    update();
  }

  void getCart() {
    cart.value = getCartUsecase.call();
    totalCart.value = getTotalCart.call();
  }
}
