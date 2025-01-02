import 'package:flutter/material.dart';
import 'package:new_prepaid_demo/domain/models/reload_plan.dart';
import 'package:new_prepaid_demo/presentation/reload/widgets/reload_item.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SelectableReloadItem extends StatelessWidget {
  final bool isLoading;
  final double width;
  final double height;
  final ReloadPlan plan;
  final bool isSelected;
  final void Function(ReloadPlan)? onSelect;

  const SelectableReloadItem({
    super.key,
    required this.isLoading,
    required this.width,
    required this.height,
    required this.plan,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: isLoading,
      child: GestureDetector(
        onTap: () {
          onSelect?.call(plan);
        },
        child: ReloadItem(
          width: width,
          height: height,
          plan: plan,
          activeBorder:
              isSelected ? Border.all(color: Theme.of(context).primaryColor, width: 2.0) : null,
        ),
      ),
    );
  }
}
