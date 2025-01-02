import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:new_prepaid_demo/domain/models/reload_plan.dart';
import 'package:new_prepaid_demo/domain/repositories/plan_repository.dart';

part 'plan_event.dart';
part 'plan_state.dart';

class PlanBloc extends Bloc<PlanEvent, PlanState> {
  final PlanRepository _repository;

  PlanBloc({required PlanRepository repository})
      : _repository = repository,
        super(const PlanFetchInitial()) {
    on<PlanFetch>(_fetchReloadPlans);
  }

  Future<void> _fetchReloadPlans(PlanFetch event, Emitter<PlanState> emit) async {
    try {
      emit(const PlanFetchLoading());
      final plans = await _repository.getReloadPlans();
      emit(PlanFetchSuccess(plans: plans));
    } on Exception catch (ex) {
      emit(PlanFetchFailure(exception: ex));
    }
  }
}
