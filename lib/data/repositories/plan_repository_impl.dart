import 'package:new_prepaid_demo/domain/models/reload_plan.dart';
import 'package:new_prepaid_demo/domain/repositories/plan_repository.dart';
import 'package:uuid/uuid.dart';

class PlanRepositoryImpl extends PlanRepository {
  @override
  Future<List<ReloadPlan>> getReloadPlans() async {
    await Future.delayed(const Duration(seconds: 2));

    return [
      ReloadPlan(
        id: const Uuid().v4(),
        amount: 5,
        availableDays: 7,
      ),
      ReloadPlan(
        id: const Uuid().v4(),
        amount: 10,
        availableDays: 30,
      ),
      ReloadPlan(
        id: const Uuid().v4(),
        amount: 20,
        availableDays: 30,
      ),
      ReloadPlan(
        id: const Uuid().v4(),
        amount: 30,
        availableDays: 30,
      ),
      ReloadPlan(
        id: const Uuid().v4(),
        amount: 40,
        availableDays: 30,
      ),
      ReloadPlan(
        id: const Uuid().v4(),
        amount: 50,
        availableDays: 30,
      ),
    ];
  }

  @override
  Future<void> purchasePlan(ReloadPlan reloadPlan) async {
    await Future.delayed(const Duration(seconds: 3));
  }
}
