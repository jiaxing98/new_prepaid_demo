part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {
  const ProfileEvent();
}

final class ProfileFetch extends ProfileEvent {
  const ProfileFetch();
}
