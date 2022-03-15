import 'package:flutter/material.dart';
import 'package:flutter_architecture/di/injection.dart';
import 'package:flutter_architecture/domain/products/entites/product.dart';
import 'package:flutter_architecture/feature/screens/cart_screen/controller/cart_controller.dart';
import 'package:flutter_architecture/feature/screens/cart_screen/widgets/add_decrease_button.dart';
import 'package:flutter_architecture/state/lifecycle/lifecycle.dart';
import 'package:flutter_architecture/state/state_builder/state_builder.dart';
import 'package:get/get.dart';

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
        title: const Text('Cart'),
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
                final product = data.products[index];

                return Dismissible(
                  key: Key(product.id.toString()),
                  confirmDismiss: (direction) async {
                    return await Get.dialog(AlertDialog(
                      title: const Text('Are you sure about that?'),
                      actions: [
                        ElevatedButton(
                          onPressed: () => Get.back(result: false),
                          child: const Text('No'),
                        ),
                        TextButton(
                          onPressed: () => Get.back(result: true),
                          child: const Text('Yes'),
                        )
                      ],
                    ));
                  },
                  onDismissed: (direction) =>
                      _controller.removeProductAt(index),
                  child: _buildCartCard(product),
                );
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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(product.name),
                      Text('USD ${product.price}'),
                    ],
                  ),
                ),
                AddDecreaseButton(
                  buttonType: ButtonType.decrease,
                  onTap: () =>
                      _controller.decreaseQuantityItemFromCart(product),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(product.qty.toString()),
                ),
                AddDecreaseButton(
                  buttonType: ButtonType.add,
                  onTap: () => _controller.addQuantityItemFromCart(product),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
