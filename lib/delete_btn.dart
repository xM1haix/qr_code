import 'package:flutter/material.dart';

class DeleteBtn extends StatelessWidget {
  final void Function()? onPressed;
  const DeleteBtn({required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        Icons.delete_outline,
        color: Colors.red,
      ),
    );
  }
}
