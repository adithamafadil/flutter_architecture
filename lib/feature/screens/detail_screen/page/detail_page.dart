import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_architecture/feature/screens/detail_screen/arguments/detail_arguments.dart';
import 'package:flutter_architecture/feature/screens/detail_screen/controller/detail_controller.dart';
import 'package:flutter_architecture/feature/widgets/color_variant_builder.dart';
import 'package:flutter_architecture/state/lifecycle/lifecycle.dart';

class DetailPage extends MyLifecycle<DetailController> {
  DetailPage({Key? key}) : super(key: key);

  final arguments = Get.arguments as DetailArguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          arguments.product.name,
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {},
            child: const Text('Add to Cart'),
          ),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Image.network(
            arguments.product.imageLink,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(arguments.product.name),
                Text(arguments.product.price),
                const SizedBox(height: 16),
                ColorVariantBuilder(
                  product: arguments.product,
                  radius: 15,
                ),
                const SizedBox(height: 16),
                Text(arguments.product.description)
              ],
            ),
          )
        ],
      ),
    );
  }
}
