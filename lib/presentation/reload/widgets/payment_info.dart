import 'package:flutter/material.dart';
import 'package:new_prepaid_demo/domain/models/reload_plan.dart';
import 'package:new_prepaid_demo/presentation/reload/widgets/reload_item.dart';

class PaymentInfo extends StatelessWidget {
  final ReloadPlan plan;

  const PaymentInfo({super.key, required this.plan});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        children: [
          ReloadItem(
            plan: plan,
            activeBorder: Border.all(color: Theme.of(context).primaryColor, width: 2.0),
          ),
          SizedBox(width: 30.0),
          Text(
            "Reload ${plan.amountText}",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
