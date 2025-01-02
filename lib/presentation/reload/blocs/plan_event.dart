part of 'plan_bloc.dart';

@immutable
sealed class PlanEvent {
  const PlanEvent();
}

final class PlanFetch extends PlanEvent {
  const PlanFetch();
}
