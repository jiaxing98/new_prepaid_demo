import 'package:flutter/material.dart';
import 'package:new_prepaid_demo/core/extensions/build_context.dart';

enum PaymentType { eWallet, fpx, card }

class PaymentMethod extends StatelessWidget {
  final PaymentType? selectedPaymentType;
  final void Function(PaymentType)? onSelect;

  const PaymentMethod({
    super.key,
    required this.selectedPaymentType,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Payment Method"),
        SizedBox(height: 8.0),
        PaymentMethodItem(
          label: "eWallet",
          paymentType: PaymentType.eWallet,
          isSelected: selectedPaymentType == PaymentType.eWallet,
          onSelect: onSelect,
        ),
        PaymentMethodItem(
          label: "Online Banking (FPX)",
          paymentType: PaymentType.fpx,
          isSelected: selectedPaymentType == PaymentType.fpx,
          onSelect: onSelect,
        ),
        PaymentMethodItem(
          label: "Credit/ Debit Card",
          paymentType: PaymentType.card,
          isSelected: selectedPaymentType == PaymentType.card,
          onSelect: onSelect,
        ),
        SizedBox(height: 16.0),
        Divider(),
      ],
    );
  }
}

class PaymentMethodItem extends StatelessWidget {
  final String label;
  final PaymentType paymentType;
  final bool isSelected;
  final void Function(PaymentType)? onSelect;

  const PaymentMethodItem({
    super.key,
    required this.label,
    required this.paymentType,
    required this.isSelected,
    this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onSelect?.call(paymentType);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: isSelected ? context.colorScheme.primary : Colors.grey,
            border: isSelected
                ? Border.all(color: context.colorScheme.primaryContainer, width: 2.0)
                : Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
