import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:new_prepaid_demo/domain/repositories/account_repository.dart';

part 'change_password_event.dart';
part 'change_password_state.dart';

class ChangePasswordBloc extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  final AccountRepository _repository;

  ChangePasswordBloc({required AccountRepository repository})
      : _repository = repository,
        super(const ChangePasswordInitial()) {
    on<ChangePasswordRequested>(_changePassword);
  }

  Future<void> _changePassword(
      ChangePasswordRequested event, Emitter<ChangePasswordState> emit) async {
    emit(const ChangePasswordLoading());

    try {
      await _repository.changePassword(event.currentPassword, event.newPassword);
      emit(const ChangePasswordSuccess());
    } on Exception catch (ex) {
      emit(ChangePasswordFailure(exception: ex));
    }
  }
}
