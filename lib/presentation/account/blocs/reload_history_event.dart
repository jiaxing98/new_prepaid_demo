part of 'reload_history_bloc.dart';

@immutable
sealed class ReloadHistoryEvent {
  const ReloadHistoryEvent();
}

final class ReloadHistoryFetch extends ReloadHistoryEvent {
  const ReloadHistoryFetch();
}
