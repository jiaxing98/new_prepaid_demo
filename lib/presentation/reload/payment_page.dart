import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:new_prepaid_demo/core/service_locator.dart';
import 'package:new_prepaid_demo/domain/models/reload_plan.dart';
import 'package:new_prepaid_demo/presentation/_shared/widgets/cta_outlined_button.dart';
import 'package:new_prepaid_demo/presentation/_shared/widgets/dialogs/single_button_dialog.dart';
import 'package:new_prepaid_demo/presentation/_shared/widgets/stylish_scaffold.dart';
import 'package:new_prepaid_demo/presentation/profile/blocs/profile_bloc.dart';
import 'package:new_prepaid_demo/presentation/reload/blocs/payment_bloc.dart';
import 'package:new_prepaid_demo/presentation/reload/widgets/payment_amount.dart';
import 'package:new_prepaid_demo/presentation/reload/widgets/payment_info.dart';
import 'package:new_prepaid_demo/presentation/reload/widgets/payment_method.dart';
import 'package:new_prepaid_demo/router/router.dart';

class PaymentPage extends StatefulWidget {
  final ReloadPlan selectedPlan;

  const PaymentPage({super.key, required this.selectedPlan});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  PaymentType? selectedPaymentType;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProfileBloc>.value(
          value: sl.get(),
        ),
        BlocProvider<PaymentBloc>(
          create: (context) => sl.get(),
        ),
      ],
      child: StylishScaffold(
        title: "Payment",
        child: BlocConsumer<PaymentBloc, PaymentState>(
          listener: _handleListener,
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      PaymentInfo(plan: widget.selectedPlan),
                      SizedBox(height: 32.0),
                      PaymentMethod(
                        selectedPaymentType: selectedPaymentType,
                        onSelect: (paymentType) {
                          setState(() {
                            selectedPaymentType = paymentType;
                          });
                        },
                      ),
                      PaymentAmount(amount: widget.selectedPlan.amountText),
                    ],
                  ),
                ),
                CTAOutlinedButton(
                  label: "Pay Now",
                  onPressed: selectedPaymentType != null
                      ? () => context.read<PaymentBloc>().add(
                            PaymentRequestMade(
                              selectedPlan: widget.selectedPlan,
                              paymentType: selectedPaymentType!,
                            ),
                          )
                      : null,
                )
              ],
            );
          },
        ),
      ),
    );
  }

  void _handleListener(BuildContext context, PaymentState state) {
    switch (state) {
      case PaymentLoading():
        context.loaderOverlay.show();
      case PaymentSuccess():
        context.loaderOverlay.hide();
        showDialog(
          context: context,
          builder: (ctx) => SingleButtonDialog(
            title: "Payment Success",
            message: "Payment has been made successfully.",
            label: 'OKAY',
            onPressed: () {
              context.goNamed(Routes.home);
            },
          ),
        );
      case PaymentFailure():
        context.loaderOverlay.hide();
        showDialog(
          context: context,
          builder: (ctx) => SingleButtonDialog(
            title: "Payment Failure",
            message: state.exception.toString(),
            label: 'OKAY',
            onPressed: () {
              context.pop();
            },
          ),
        );
      default:
        context.loaderOverlay.hide();
        break;
    }
  }
}
