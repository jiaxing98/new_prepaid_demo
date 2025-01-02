part of 'payment_bloc.dart';

@immutable
sealed class PaymentEvent {
  const PaymentEvent();
}

class PaymentRequestMade extends PaymentEvent {
  final ReloadPlan selectedPlan;
  final PaymentType paymentType;

  const PaymentRequestMade({
    required this.selectedPlan,
    required this.paymentType,
  });
}
