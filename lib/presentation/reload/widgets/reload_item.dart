import 'package:flutter/material.dart';
import 'package:new_prepaid_demo/core/extensions/build_context.dart';
import 'package:new_prepaid_demo/domain/models/reload_plan.dart';

class ReloadItem extends StatelessWidget {
  final ReloadPlan plan;
  final double? width;
  final double? height;
  final Border? activeBorder;

  const ReloadItem({
    super.key,
    required this.plan,
    this.width,
    this.height,
    this.activeBorder,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: context.colorScheme.primary,
        border: activeBorder ?? Border.all(color: context.colorScheme.primaryContainer),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Align(
                alignment: Alignment.topCenter,
                child: Text(
                  'RM ',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  plan.amount.toString(),
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Text(
            "${plan.availableDays.toString()} days \nvalidity",
            textAlign: TextAlign.center,
            style: TextStyle(color: context.colorScheme.onPrimary),
          ),
        ],
      ),
    );
  }
}
