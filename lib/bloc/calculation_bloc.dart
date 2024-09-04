import 'package:bloc/bloc.dart';
import 'package:calculatorapp/bloc/events/calculation_event.dart';
import 'package:calculatorapp/bloc/model/screen_items.dart';
import 'package:calculatorapp/bloc/state/calculation_state.dart';

class CalculationBloc extends Bloc<CalculationEvent, CalculationState> {
  CalculationBloc() : super(CalculationState());

  void onItemTap(String receivedValue) {
    if (receivedValue == ScreenItems.clear) {
      clearAll();
    } else if (receivedValue == ScreenItems.percentage) {
      convertToPercentage();
    } else if (receivedValue == ScreenItems.equal) {
      finalOutput();
    } else {
      appendValue(receivedValue);
    }
  }

  void finalOutput() {
    if (state.firstValue.isEmpty || state.usedOperand.isEmpty || state.secondValue.isEmpty) return;

    final num number1 = num.parse(state.firstValue);
    final num number2 = num.parse(state.secondValue);

    num result;
    switch (state.usedOperand) {
      case ScreenItems.addition:
        result = number1 + number2;
        break;
      case ScreenItems.subtract:
        result = number1 - number2;
        break;
      case ScreenItems.multiplication:
        result = number1 * number2;
        break;
      case ScreenItems.division:
        result = number1 / number2;
        break;
      case ScreenItems.plusminus:
        result = -number1;
        break;
      default:
        return;
    }

    final formattedResult = result.toStringAsPrecision(3).replaceAll(RegExp(r'\.0$'), '');
    emit(state.copyWith(
      firstValue: formattedResult,
      usedOperand: "",
      secondValue: "",
    ));
  }

  void convertToPercentage() {
    if (state.firstValue.isNotEmpty && state.usedOperand.isNotEmpty && state.secondValue.isNotEmpty) {
      finalOutput();
    }

    if (state.usedOperand.isNotEmpty) return;
    if (state.firstValue.isEmpty) return;

    final number = num.parse(state.firstValue);
    final formattedNumber = (number / 100).toString();
    emit(state.copyWith(
      firstValue: formattedNumber,
      usedOperand: "",
      secondValue: "",
    ));
  }

  void clearAll() {
    emit(CalculationState());
  }

  void appendValue(String value) {
    if (value != ScreenItems.decimal && int.tryParse(value) == null) {
      if (state.usedOperand.isNotEmpty && state.secondValue.isNotEmpty) {
        finalOutput();
      }
      emit(state.copyWith(
        usedOperand: value,
        secondValue: state.secondValue.isNotEmpty ? state.secondValue : "",
      ));
    } else if (state.firstValue.isEmpty || state.usedOperand.isEmpty) {
      if (value == ScreenItems.decimal && state.firstValue.contains(ScreenItems.decimal)) return;
      if (value == ScreenItems.decimal && (state.firstValue.isEmpty || state.firstValue == ScreenItems.number0)) {
        value = "0.";
      }
      emit(state.copyWith(
        firstValue: state.firstValue + value,
      ));
    } else if (state.secondValue.isEmpty || state.usedOperand.isNotEmpty) {
      if (value == ScreenItems.decimal && state.secondValue.contains(ScreenItems.decimal)) return;
      if (value == ScreenItems.decimal && (state.secondValue.isEmpty || state.secondValue == ScreenItems.number0)) {
        value = "0.";
      }
      emit(state.copyWith(
        secondValue: state.secondValue + value,
      ));
    }
  }
}
