import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_architecture/state/view_data/view_data_state.dart';

import '../../../../domain/cart/cart_domain.dart';
import '../../../../domain/products/products_domain.dart';

@injectable
class HomeController extends GetxController {
  final GetProductUsecase getProduct;
  final GetCartUsecase getCartUsecase;
  final GetTotalCart getTotalCart;
  final AddProductToCart addProductToCart;

  HomeController({
    required this.getProduct,
    required this.getCartUsecase,
    required this.getTotalCart,
    required this.addProductToCart,
  });

  final Rx<ViewDataState<List<Product>>> productState =
      Rx(const ViewDataState.initial());
  Rx<Cart> cart = Rx(Cart(products: []));
  RxInt totalCart = 0.obs;

  Future<void> getProducts() async {
    productState.value = const ViewDataState.loading();
    update();

    final result = await getProduct.call();

    result.when(
      success: (data) => productState.value = ViewDataState.success(data: data),
      error: (message, data, statusCode, exception, stackTrace) =>
          productState.value = ViewDataState.error(message: message),
    );
    update();
  }

  Future<void> addItemToCart(Product product) async {
    await addProductToCart.call(product);
    update();

    getCart();
    update();
  }

  void getCart() {
    cart.value = getCartUsecase.call();
    totalCart.value = getTotalCart.call();
  }
}
