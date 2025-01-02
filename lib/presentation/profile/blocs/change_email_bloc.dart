import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:new_prepaid_demo/domain/repositories/account_repository.dart';

part 'change_email_event.dart';
part 'change_email_state.dart';

class ChangeEmailBloc extends Bloc<ChangeEmailEvent, ChangeEmailState> {
  final AccountRepository _repository;

  ChangeEmailBloc({required AccountRepository repository})
      : _repository = repository,
        super(const ChangeEmailInitial()) {
    on<ChangeEmailRequested>(_changeEmail);
  }

  Future<void> _changeEmail(ChangeEmailRequested event, Emitter<ChangeEmailState> emit) async {
    emit(const ChangeEmailLoading());

    try {
      await _repository.changeEmail(event.confirmEmail, event.newEmail);
      emit(const ChangeEmailSuccess());
    } on Exception catch (ex) {
      emit(ChangeEmailFailure(exception: ex));
    }
  }
}
