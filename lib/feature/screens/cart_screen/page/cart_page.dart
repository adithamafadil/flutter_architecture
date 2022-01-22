import 'package:flutter/material.dart';
import 'package:flutter_architecture/data/products/domain/entites/product.dart';
import 'package:flutter_architecture/di/injection.dart';
import 'package:flutter_architecture/feature/screens/cart_screen/controller/cart_controller.dart';
import 'package:flutter_architecture/state/lifecycle/lifecycle.dart';
import 'package:flutter_architecture/state/state_builder/state_builder.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class CartPage extends MyLifecycle<CartController> {
  CartPage({Key? key}) : super(key: key);

  final _controller = inject<CartController>();

  @override
  void onReady(GetBuilderState<CartController> controller) {
    controller.controller?.getCart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => _controller.deleteCart(),
            icon: const Icon(
              Icons.delete_forever_outlined,
              color: Colors.redAccent,
            ),
          )
        ],
      ),
      body: StateBuilder<CartController>(
        context: context,
        container: this,
        init: _controller,
        builder: (controller) {
          return controller.cartState.value.maybeWhen(
            success: (data) => ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: data.products.length,
              itemBuilder: (_, index) {
                var product = data.products[index];

                return _buildCartCard(product);
              },
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            orElse: () {
              return const Text('Error');
            },
          );
        },
      ),
    );
  }

  Widget _buildCartCard(Product product) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Card(
          elevation: 7,
          borderOnForeground: true,
          child: SizedBox(
            height: 100,
            child: Row(
              children: [
                Image.network(
                  product.imageLink,
                  fit: BoxFit.fitHeight,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(product.name),
                    Text('USD ${product.price} x ${product.qty}'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
