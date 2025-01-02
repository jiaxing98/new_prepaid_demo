class ReloadPlan {
  final String id;
  final int amount;
  final int availableDays;

  ReloadPlan({
    required this.id,
    required this.amount,
    required this.availableDays,
  });

  String get amountText => "RM$amount";
}
