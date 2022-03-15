import 'package:flutter/material.dart';
import 'package:flutter_architecture/domain/products/entites/product.dart';
import 'package:flutter_architecture/feature/utils/color_extension.dart';
import 'package:flutter_architecture/feature/utils/grayscale_checker.dart';

class ColorVariantBuilder extends StatelessWidget {
  final Product product;
  final double radius;
  final bool isWithLabel;
  const ColorVariantBuilder({
    Key? key,
    required this.product,
    this.radius = 12.5,
    this.isWithLabel = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: radius * 2,
      child: ListView.builder(
        itemCount: product.productColors.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          Color color = HexColor.fromHex(product.productColors[index].hexValue);

          return Container(
            height: radius * 2,
            width: isWithLabel ? null : radius * 2,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(99),
              color: color,
              border: Border.all(color: Colors.black38),
            ),
            child: isWithLabel
                ? Padding(
                    padding: const EdgeInsets.all(4),
                    child: Text(
                      product.productColors[index].colourName ??
                          'No Color Name',
                      style: TextStyle(
                        color: GrayscaleChecker.isDarkColor(color)
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          );
        },
      ),
    );
  }
}
