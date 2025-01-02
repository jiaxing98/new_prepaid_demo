import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:new_prepaid_demo/domain/models/profile.dart';
import 'package:new_prepaid_demo/domain/repositories/account_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AccountRepository _repository;

  ProfileBloc({required AccountRepository repository})
      : _repository = repository,
        super(const ProfileFetchInitial()) {
    on<ProfileFetch>(_fetchProfile);
  }

  Future<void> _fetchProfile(ProfileFetch event, Emitter<ProfileState> emit) async {
    emit(const ProfileFetchLoading());

    try {
      final profile = await _repository.getProfile();
      emit(ProfileFetchSuccess(profile: profile));
    } on Exception catch (ex) {
      emit(ProfileFetchFailure(exception: ex));
    }
  }
}
