import 'package:flutter/material.dart';

class UpdateButton extends StatelessWidget {
  final String label;
  final void Function() onPressed;

  const UpdateButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
