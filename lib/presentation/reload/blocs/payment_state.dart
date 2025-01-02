part of 'payment_bloc.dart';

@immutable
sealed class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object> get props => [];
}

final class PaymentInitial extends PaymentState {
  const PaymentInitial();
}

final class PaymentLoading extends PaymentState {
  const PaymentLoading();
}

final class PaymentSuccess extends PaymentState {
  const PaymentSuccess();
}

final class PaymentFailure extends PaymentState {
  final Exception exception;

  const PaymentFailure({
    required this.exception,
  });

  @override
  List<Object> get props => [exception];
}
