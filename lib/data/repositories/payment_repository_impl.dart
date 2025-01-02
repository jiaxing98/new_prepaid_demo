import 'package:new_prepaid_demo/domain/repositories/payment_repository.dart';

class PaymentRepositoryImpl extends PaymentRepository {
  @override
  Future<void> makePaymentWithEWallet() async {
    await Future.delayed(Duration(seconds: 2));
    throw Exception("something went wrong");
  }

  @override
  Future<void> makePaymentWithFPX() async {
    await Future.delayed(Duration(seconds: 2));
  }

  @override
  Future<void> makePaymentWithCard() async {
    await Future.delayed(Duration(seconds: 2));
  }
}
