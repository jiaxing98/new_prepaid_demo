import 'package:flutter/material.dart';

class CTAElevatedButton extends StatelessWidget {
  final String label;
  final void Function()? onPressed;

  const CTAElevatedButton({
    super.key,
    required this.label,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        ),
        foregroundColor: MaterialStateProperty.all(Colors.white),
        backgroundColor: MaterialStateProperty.resolveWith(
          (states) {
            return states.contains(MaterialState.disabled)
                ? Theme.of(context).primaryColor.withOpacity(0.5)
                : Theme.of(context).primaryColor;
          },
        ),
      ),
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
