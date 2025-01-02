import 'package:flutter/material.dart';
import 'package:new_prepaid_demo/presentation/_shared/widgets/cta_elevated_button.dart';
import 'package:new_prepaid_demo/presentation/_shared/widgets/dialogs/app_dialog.dart';

class SingleButtonDialog extends StatelessWidget {
  final String title;
  final String message;
  final String label;
  final void Function() onPressed;

  const SingleButtonDialog({
    super.key,
    required this.title,
    required this.message,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppDialog(
      title: title,
      message: message,
      action: CTAElevatedButton(
        onPressed: onPressed,
        label: label,
      ),
    );
  }
}
