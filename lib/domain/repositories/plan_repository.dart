import 'package:new_prepaid_demo/domain/models/reload_plan.dart';

abstract class PlanRepository {
  Future<List<ReloadPlan>> getReloadPlans();
  Future<void> purchasePlan(ReloadPlan reloadPlan);
}
