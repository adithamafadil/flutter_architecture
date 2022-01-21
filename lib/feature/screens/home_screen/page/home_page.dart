import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
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

  final HomeController _controller = inject<HomeController>();

  @override
  void onReady(GetBuilderState<HomeController> controller) {
    controller.controller?.getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StateBuilder<HomeController>(
        container: this,
        context: context,
        init: _controller,
        builder: (controller) => Center(
          child: controller.productState.value.maybeWhen(
            loading: () => const CircularProgressIndicator(),
            success: (data) => ListView.builder(
              shrinkWrap: true,
              itemCount: data.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (_, index) => _buildProductCard(data[index]),
            ),
            error: (message, _) => Text(message),
            orElse: () => const Text('Unhandled Error'),
          ),
        ),
      ),
    );
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
            onTap: () => Get.toNamed(
              MyConstants.routes.detail,
              arguments: DetailArguments(product: product),
            ),
            child: Material(
              color: Colors.transparent,
              child: Row(
                children: [
                  Image.network(
                    product.imageLink,
                    height: 100,
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
                          ColorVariantBuilder(product: product)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
