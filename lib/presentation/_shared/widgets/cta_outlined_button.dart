import 'package:flutter/material.dart';

class CTAOutlinedButton extends StatelessWidget {
  final String label;
  final void Function()? onPressed;

  const CTAOutlinedButton({
    super.key,
    required this.label,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        ),
        foregroundColor: MaterialStateProperty.resolveWith(
          (states) {
            return states.contains(MaterialState.disabled) ? null : Theme.of(context).primaryColor;
          },
        ),
        side: MaterialStateProperty.resolveWith(
          (states) {
            return states.contains(MaterialState.disabled)
                ? null
                : BorderSide(color: Theme.of(context).primaryColor, width: 2.0);
          },
        ),
      ),
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
