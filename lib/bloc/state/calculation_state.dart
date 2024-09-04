class CalculationState {
  final String firstValue;
  final String usedOperand;
  final String secondValue;

  CalculationState({
    this.firstValue = "",
    this.usedOperand = "",
    this.secondValue = "",
  });

  CalculationState copyWith({
    String? firstValue,
    String? usedOperand,
    String? secondValue,
  }) {
    return CalculationState(
      firstValue: firstValue ?? this.firstValue,
      usedOperand: usedOperand ?? this.usedOperand,
      secondValue: secondValue ?? this.secondValue,
    );
  }
}
