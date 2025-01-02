part of 'change_password_bloc.dart';

@immutable
sealed class ChangePasswordState extends Equatable {
  const ChangePasswordState();

  @override
  List<Object?> get props => [];
}

final class ChangePasswordInitial extends ChangePasswordState {
  const ChangePasswordInitial();

  @override
  List<Object?> get props => [];
}

final class ChangePasswordLoading extends ChangePasswordState {
  const ChangePasswordLoading();

  @override
  List<Object?> get props => [];
}

final class ChangePasswordSuccess extends ChangePasswordState {
  const ChangePasswordSuccess();

  @override
  List<Object?> get props => [];
}

final class ChangePasswordFailure extends ChangePasswordState {
  final Exception exception;

  const ChangePasswordFailure({required this.exception});

  @override
  List<Object?> get props => [exception];
}
