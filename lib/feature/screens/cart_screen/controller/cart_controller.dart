import 'package:flutter_architecture/domain/cart/cart_domain.dart';
import 'package:flutter_architecture/domain/products/entites/product.dart';
import 'package:flutter_architecture/state/view_data/view_data_state.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:injectable/injectable.dart';

@injectable
class CartController extends GetxController {
  final AddProductToCart addProductToCart;
  final DecreaseCartUsecase decreaseCartUsecase;
  final DeleteCartUsecase deleteCartUsecase;
  final GetCartUsecase getCartUsecase;
  final RemoveProductAtUsecase removeProductAtUsecase;

  CartController({
    required this.addProductToCart,
    required this.decreaseCartUsecase,
    required this.deleteCartUsecase,
    required this.getCartUsecase,
    required this.removeProductAtUsecase,
  });

  Rx<Cart> cart = Rx(Cart(products: []));
  Rx<ViewDataState<Cart>> cartState = Rx(const ViewDataState.initial());

  void getCart() {
    cartState.value = const ViewDataState.loading();
    update();

    _callGetCartUsecaseHelper();
    update();
  }

  void deleteCart() {
    cartState.value = const ViewDataState.loading();
    update();
    deleteCartUsecase.call();

    _callGetCartUsecaseHelper();
    update();
  }

  void removeProductAt(int index) {
    cartState.value = const ViewDataState.loading();
    update();

    removeProductAtUsecase.call(index);

    _callGetCartUsecaseHelper();
    update();
  }

  void addQuantityItemFromCart(Product product) async {
    await addProductToCart.call(product);

    _callGetCartUsecaseHelper();
    update();
  }

  void decreaseQuantityItemFromCart(Product product) async {
    if (product.qty > 1) {
      await decreaseCartUsecase.call(product);
    } else {
      cart.value = getCartUsecase.call();
      update();

      removeProductAt(
        cart.value.products.indexWhere((element) => element.id == product.id),
      );
    }

    _callGetCartUsecaseHelper();
    update();
  }

  void _callGetCartUsecaseHelper() {
    cart.value = getCartUsecase.call();
    cartState.value = ViewDataState.success(data: cart.value);
  }
}
