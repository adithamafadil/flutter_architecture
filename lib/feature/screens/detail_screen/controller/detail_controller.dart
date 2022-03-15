import 'package:flutter_architecture/domain/cart/cart_domain.dart';
import 'package:flutter_architecture/domain/products/entites/product.dart';
import 'package:get/state_manager.dart';
import 'package:injectable/injectable.dart';

@injectable
class DetailController extends GetxController {
  final GetCartUsecase getCartUsecase;
  final GetTotalCart getTotalCart;
  final AddProductToCart addProductToCart;

  DetailController({
    required this.getCartUsecase,
    required this.getTotalCart,
    required this.addProductToCart,
  });

  Rx<Cart> cart = Rx(Cart(products: []));
  RxInt totalCart = 0.obs;

  Future<void> addItemToCart(Product product) async {
    addProductToCart.call(product);
    update();

    getCart();
    update();
  }

  void getCart() {
    cart.value = getCartUsecase.call();
    totalCart.value = getTotalCart.call();
  }
}
