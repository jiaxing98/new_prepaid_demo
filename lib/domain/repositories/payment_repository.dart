abstract class PaymentRepository {
  Future<void> makePaymentWithEWallet();
  Future<void> makePaymentWithFPX();
  Future<void> makePaymentWithCard();
}
