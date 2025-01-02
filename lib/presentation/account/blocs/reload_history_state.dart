part of 'reload_history_bloc.dart';

@immutable
sealed class ReloadHistoryState extends Equatable {
  const ReloadHistoryState();
}

final class ReloadHistoryFetchInitial extends ReloadHistoryState {
  const ReloadHistoryFetchInitial();

  @override
  List<Object?> get props => [];
}

final class ReloadHistoryFetchLoading extends ReloadHistoryState {
  const ReloadHistoryFetchLoading();

  @override
  List<Object?> get props => [];
}

final class ReloadHistoryFetchSuccess extends ReloadHistoryState {
  final List<ReloadHistory> reloadHistories;

  const ReloadHistoryFetchSuccess({required this.reloadHistories});

  Map<DateTime, List<ReloadHistory>> get reloadHistoriesGroupByMonth {
    return Map.fromEntries(
      groupBy(
        reloadHistories,
        (ReloadHistory history) => DateTime(history.dateTime.year, history.dateTime.month),
      ).entries.toList()
        ..sort((e1, e2) => e1.key.compareTo(e2.key)),
    );
  }

  @override
  List<Object> get props => [
        reloadHistories,
      ];

  ReloadHistoryFetchSuccess copyWith({
    List<ReloadHistory>? reloadHistories,
  }) {
    return ReloadHistoryFetchSuccess(
      reloadHistories: reloadHistories ?? this.reloadHistories,
    );
  }
}

final class ReloadHistoryFetchFailure extends ReloadHistoryState {
  final Exception exception;

  const ReloadHistoryFetchFailure({required this.exception});

  @override
  List<Object?> get props => [exception];
}
