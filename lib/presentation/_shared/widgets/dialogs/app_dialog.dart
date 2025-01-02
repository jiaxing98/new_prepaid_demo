import 'package:flutter/material.dart';

class AppDialog extends StatelessWidget {
  final String title;
  final String message;
  final Widget action;

  const AppDialog({
    super.key,
    required this.title,
    required this.message,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              message,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.0),
            action,
          ],
        ),
      ),
    );
  }
}
