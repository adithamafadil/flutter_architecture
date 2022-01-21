import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_architecture/data/products/domain/entites/product.dart';
import 'package:flutter_architecture/data/products/domain/usecases/get_product_usecase.dart';
import 'package:flutter_architecture/state/view_data/view_data_state.dart';

@injectable
class HomeController extends GetxController {
  final GetProductUsecase getProduct;

  HomeController({required this.getProduct});

  final Rx<ViewDataState<List<Product>>> productState =
      Rx(const ViewDataState.initial());

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
}
