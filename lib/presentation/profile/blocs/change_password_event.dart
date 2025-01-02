part of 'change_password_bloc.dart';

@immutable
sealed class ChangePasswordEvent {
  const ChangePasswordEvent();
}

final class ChangePasswordRequested extends ChangePasswordEvent {
  final String currentPassword;
  final String newPassword;

  const ChangePasswordRequested({
    required this.currentPassword,
    required this.newPassword,
  });
}
