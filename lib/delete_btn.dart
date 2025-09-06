import "package:flutter/material.dart";

class DeleteBtn extends StatelessWidget {
  const DeleteBtn({required this.onPressed, super.key});
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: const Icon(
        Icons.delete_outline,
        color: Colors.red,
      ),
    );
  }
}
