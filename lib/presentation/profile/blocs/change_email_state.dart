part of 'change_email_bloc.dart';

@immutable
sealed class ChangeEmailState extends Equatable {
  const ChangeEmailState();
}

final class ChangeEmailInitial extends ChangeEmailState {
  const ChangeEmailInitial();

  @override
  List<Object?> get props => [];
}

final class ChangeEmailLoading extends ChangeEmailState {
  const ChangeEmailLoading();

  @override
  List<Object?> get props => [];
}

final class ChangeEmailSuccess extends ChangeEmailState {
  const ChangeEmailSuccess();

  @override
  List<Object?> get props => [];
}

final class ChangeEmailFailure extends ChangeEmailState {
  final Exception exception;

  const ChangeEmailFailure({required this.exception});

  @override
  List<Object?> get props => [exception];
}
