import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:new_prepaid_demo/domain/models/reload_history.dart';
import 'package:new_prepaid_demo/domain/repositories/account_repository.dart';

part 'reload_history_event.dart';
part 'reload_history_state.dart';

class ReloadHistoryBloc extends Bloc<ReloadHistoryEvent, ReloadHistoryState> {
  final AccountRepository _repository;

  ReloadHistoryBloc({required AccountRepository repository})
      : _repository = repository,
        super(const ReloadHistoryFetchInitial()) {
    on<ReloadHistoryFetch>(_fetchReloadHistory);
  }

  Future _fetchReloadHistory(ReloadHistoryFetch event, Emitter<ReloadHistoryState> emit) async {
    emit(const ReloadHistoryFetchLoading());

    try {
      final reloadHistories = await _repository.getReloadHistories();
      emit(ReloadHistoryFetchSuccess(reloadHistories: reloadHistories));
    } on Exception catch (ex) {
      emit(ReloadHistoryFetchFailure(exception: ex));
    }
  }
}
