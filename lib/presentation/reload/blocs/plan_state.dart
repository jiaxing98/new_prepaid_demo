part of 'plan_bloc.dart';

@immutable
sealed class PlanState extends Equatable {
  const PlanState();
}

final class PlanFetchInitial extends PlanState {
  const PlanFetchInitial();

  @override
  List<Object> get props => [];
}

final class PlanFetchLoading extends PlanState {
  const PlanFetchLoading();

  @override
  List<Object> get props => [];
}

final class PlanFetchSuccess extends PlanState {
  final List<ReloadPlan> plans;

  const PlanFetchSuccess({required this.plans});

  @override
  List<Object?> get props => [plans];

  PlanFetchSuccess copyWith({
    List<ReloadPlan>? plans,
  }) {
    return PlanFetchSuccess(
      plans: plans ?? this.plans,
    );
  }
}

final class PlanFetchFailure extends PlanState {
  final Exception exception;

  const PlanFetchFailure({required this.exception});

  @override
  List<Object> get props => [exception];
}
