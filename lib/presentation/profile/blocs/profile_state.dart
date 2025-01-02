part of 'profile_bloc.dart';

@immutable
sealed class ProfileState extends Equatable {
  const ProfileState();
}

final class ProfileFetchInitial extends ProfileState {
  const ProfileFetchInitial();

  @override
  List<Object?> get props => [];
}

final class ProfileFetchLoading extends ProfileState {
  const ProfileFetchLoading();

  @override
  List<Object?> get props => [];
}

final class ProfileFetchSuccess extends ProfileState {
  final Profile profile;

  const ProfileFetchSuccess({required this.profile});

  @override
  List<Object?> get props => [profile];
}

final class ProfileFetchFailure extends ProfileState {
  final Exception exception;

  const ProfileFetchFailure({required this.exception});

  @override
  List<Object?> get props => [exception];
}
