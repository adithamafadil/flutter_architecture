import 'package:flutter/material.dart';

class CartIcon extends StatelessWidget {
  final String counterText;
  final void Function() onPressed;
  const CartIcon({Key? key, required this.counterText, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          onPressed: onPressed,
          icon: const Icon(Icons.shopping_cart_outlined),
        ),
        Positioned(
          right: 0,
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.red,
            ),
            child: Text(counterText),
          ),
        ),
      ],
    );
  }
}
