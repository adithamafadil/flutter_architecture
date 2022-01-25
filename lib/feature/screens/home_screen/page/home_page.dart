import 'package:flutter/material.dart';
import 'package:flutter_architecture/feature/widgets/cart_icon.dart';
import 'package:get/get.dart';
import 'package:flutter_architecture/constants/constants.dart';
import 'package:flutter_architecture/di/injection.dart';
import 'package:flutter_architecture/data/products/domain/entites/product.dart';
import 'package:flutter_architecture/feature/screens/detail_screen/arguments/detail_arguments.dart';
import 'package:flutter_architecture/feature/screens/home_screen/controller/home_controller.dart';
import 'package:flutter_architecture/feature/widgets/color_variant_builder.dart';
import 'package:flutter_architecture/state/lifecycle/lifecycle.dart';
import 'package:flutter_architecture/state/state_builder/state_builder.dart';

class HomePage extends MyLifecycle<HomeController> {
  HomePage({Key? key}) : super(key: key);

  final _controller = inject<HomeController>();

  @override
  void onReady(GetBuilderState<HomeController> controller) {
    controller.controller
      ?..getProducts()
      ..getCart();
  }

  @override
  Widget build(BuildContext context) {
    return StateBuilder<HomeController>(
        container: this,
        context: context,
        init: _controller,
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              actions: [
                Obx(() => CartIcon(
                      counterText: '${_controller.totalCart}',
                      onPressed: () async =>
                          await Get.toNamed(MyConstants.routes.cart)?.then(
                        (_) => _controller.getCart(),
                      ),
                    ))
              ],
            ),
            body: Center(
              child: _controller.productState.value.maybeWhen(
                loading: () => const CircularProgressIndicator(),
                success: (data) => GridView.builder(
                  shrinkWrap: true,
                  itemCount: data.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 0.55),
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (_, index) => _buildProductCard(data[index]),
                ),
                error: (message, _) => Text(message),
                orElse: () => const Text('Unhandled Error'),
              ),
            ),
          );
        });
  }

  Widget _buildProductCard(Product product) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Card(
          elevation: 7,
          borderOnForeground: true,
          child: InkWell(
            onTap: () async => await Get.toNamed(
              MyConstants.routes.detail,
              arguments: DetailArguments(product: product),
            )?.then((_) => _controller.getCart()),
            child: Material(
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: 8.0,
                  left: 4.0,
                  right: 4.0,
                ),
                child: Column(
                  children: [
                    Image.network(
                      product.imageLink,
                      fit: BoxFit.cover,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            product.name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'USD ${product.price}',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          const SizedBox(height: 12),
                          if (product.productColors.isNotEmpty)
                            ColorVariantBuilder(product: product),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => _controller.addItemToCart(product),
                      child: const Text('Add to Cart'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
