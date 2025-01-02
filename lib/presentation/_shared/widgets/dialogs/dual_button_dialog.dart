import 'package:flutter/material.dart';
import 'package:new_prepaid_demo/presentation/_shared/widgets/dialogs/app_dialog.dart';

class DualButtonDialog extends StatelessWidget {
  final String title;
  final String message;
  final String positiveLabel;
  final String negativeLabel;
  final void Function() onPositive;
  final void Function() onNegative;
  final Axis axis;

  const DualButtonDialog._({
    super.key,
    required this.title,
    required this.message,
    required this.positiveLabel,
    required this.negativeLabel,
    required this.onPositive,
    required this.onNegative,
    required this.axis,
  });

  const DualButtonDialog.horizontal({
    super.key,
    required this.title,
    required this.message,
    required this.positiveLabel,
    required this.negativeLabel,
    required this.onPositive,
    required this.onNegative,
    this.axis = Axis.horizontal,
  });

  const DualButtonDialog.vertical({
    super.key,
    required this.title,
    required this.message,
    required this.positiveLabel,
    required this.negativeLabel,
    required this.onPositive,
    required this.onNegative,
    this.axis = Axis.vertical,
  });

  @override
  Widget build(BuildContext context) {
    return AppDialog(
      title: title,
      message: message,
      action: switch (axis) {
        Axis.horizontal => Row(
            children: actionGroup,
          ),
        Axis.vertical => Column(
            children: actionGroup,
          ),
      },
    );
  }

  List<Widget> get actionGroup {
    return [
      ElevatedButton(
        onPressed: onPositive,
        child: Text(positiveLabel),
      ),
      ElevatedButton(
        onPressed: onNegative,
        child: Text(negativeLabel),
      ),
    ];
  }
}
