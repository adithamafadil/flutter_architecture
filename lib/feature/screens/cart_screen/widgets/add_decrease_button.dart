import 'package:flutter/material.dart';

enum ButtonType { add, decrease }

extension ButtonTypeExtension on ButtonType {
  bool get isAddButton => this == ButtonType.add;
  bool get isDecreaseButton => this == ButtonType.decrease;
}

class AddDecreaseButton extends StatelessWidget {
  final ButtonType buttonType;
  final void Function() onTap;

  const AddDecreaseButton({
    Key? key,
    required this.buttonType,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Icon(buttonType.isAddButton ? Icons.add : Icons.horizontal_rule),
      ),
    );
  }
}
