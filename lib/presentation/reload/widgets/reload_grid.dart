import 'package:flutter/material.dart';
import 'package:new_prepaid_demo/domain/models/reload_plan.dart';
import 'package:new_prepaid_demo/presentation/reload/widgets/selectable_reload_item.dart';

class ReloadGrid extends StatelessWidget {
  final bool isLoading;
  final List<ReloadPlan> plans;
  final ReloadPlan? selectedPlan;
  final void Function(ReloadPlan)? onSelect;

  const ReloadGrid({
    super.key,
    required this.plans,
    required this.selectedPlan,
    required this.onSelect,
  }) : isLoading = false;

  ReloadGrid.loading({
    super.key,
  })  : isLoading = true,
        plans = List.generate(
          3,
          (index) => ReloadPlan(
            id: "planId",
            amount: 5,
            availableDays: 7,
          ),
        ),
        onSelect = null,
        selectedPlan = null;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: SizedBox(
            height: constraints.maxHeight,
            width: constraints.maxWidth,
            child: Wrap(
              spacing: 12.0,
              runSpacing: 12.0,
              alignment: WrapAlignment.center,
              children: List.generate(
                plans.length,
                (index) => SelectableReloadItem(
                  isLoading: isLoading,
                  width: 105,
                  height: 120,
                  plan: plans[index],
                  isSelected: selectedPlan?.id == plans[index].id,
                  onSelect: onSelect,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
