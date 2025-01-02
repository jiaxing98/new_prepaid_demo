import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:new_prepaid_demo/domain/models/reload_plan.dart';
import 'package:new_prepaid_demo/domain/repositories/payment_repository.dart';
import 'package:new_prepaid_demo/presentation/reload/widgets/payment_method.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final PaymentRepository _repository;

  PaymentBloc({required PaymentRepository repository})
      : _repository = repository,
        super(const PaymentInitial()) {
    on<PaymentRequestMade>(_madePaymentRequest);
  }

  Future<void> _madePaymentRequest(PaymentRequestMade event, Emitter<PaymentState> emit) async {
    emit(const PaymentLoading());

    try {
      switch (event.paymentType) {
        case PaymentType.eWallet:
          await _repository.makePaymentWithEWallet();
          emit(const PaymentSuccess());
        case PaymentType.fpx:
          await _repository.makePaymentWithFPX();
          emit(const PaymentSuccess());
        case PaymentType.card:
          await _repository.makePaymentWithCard();
          emit(const PaymentSuccess());
      }
    } on Exception catch (ex) {
      emit(PaymentFailure(exception: ex));
    }
  }
}
