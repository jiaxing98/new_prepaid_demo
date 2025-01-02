part of 'change_email_bloc.dart';

@immutable
sealed class ChangeEmailEvent {
  const ChangeEmailEvent();
}

final class ChangeEmailRequested extends ChangeEmailEvent {
  final String newEmail;
  final String confirmEmail;

  const ChangeEmailRequested({
    required this.newEmail,
    required this.confirmEmail,
  });
}
