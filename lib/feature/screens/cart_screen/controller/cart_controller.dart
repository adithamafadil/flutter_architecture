import 'package:flutter_architecture/data/cart/domain/entities/cart.dart';
import 'package:flutter_architecture/data/cart/domain/usecases/delete_cart_usecase.dart';
import 'package:flutter_architecture/data/cart/domain/usecases/get_cart_usecase.dart';
import 'package:flutter_architecture/state/view_data/view_data_state.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:injectable/injectable.dart';

@injectable
class CartController extends GetxController {
  final GetCartUsecase getCartUsecase;
  final DeleteCartUsecase deleteCartUsecase;

  CartController({
    required this.getCartUsecase,
    required this.deleteCartUsecase,
  });

  Rx<Cart> cart = Rx(Cart(products: []));
  Rx<ViewDataState<Cart>> cartState = Rx(const ViewDataState.initial());

  void getCart() {
    cartState.value = const ViewDataState.loading();
    update();

    cart.value = getCartUsecase.call();
    cartState.value = ViewDataState.success(data: cart.value);
    update();
  }

  void deleteCart() {
    cartState.value = const ViewDataState.loading();
    update();
    deleteCartUsecase.call();

    cart.value = getCartUsecase.call();
    cartState.value = ViewDataState.success(data: cart.value);
    update();
  }
}
