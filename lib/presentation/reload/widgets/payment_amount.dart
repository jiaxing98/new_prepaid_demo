import 'package:flutter/material.dart';

class PaymentAmount extends StatelessWidget {
  final String amount;

  const PaymentAmount({super.key, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Total"),
          Text(
            amount,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
          ),
        ],
      ),
    );
  }
}
