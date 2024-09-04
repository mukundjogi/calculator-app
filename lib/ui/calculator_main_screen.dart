import 'package:calculatorapp/bloc/calculation_bloc.dart';
import 'package:calculatorapp/bloc/model/screen_items.dart';
import 'package:calculatorapp/bloc/state/calculation_state.dart';
import 'package:calculatorapp/custom_components/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalculatorMainScreen extends StatelessWidget {
  const CalculatorMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // output
            Expanded(
              child: SingleChildScrollView(
                reverse: true,
                child: Container(
                  alignment: Alignment.bottomRight,
                  padding: const EdgeInsets.all(16),
                  child: BlocBuilder<CalculationBloc, CalculationState>(
                    builder: (context, state) {
                      return Text(
                        "${state.firstValue}${state.usedOperand}${state.secondValue}".isEmpty
                            ? ""
                            : state.usedOperand == ScreenItems.plusminus
                            ? "${"-"}${state.firstValue}"
                            : "${state.firstValue}${state.usedOperand}${state.secondValue}",
                        style: const TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.end,
                      );
                    },
                  ),
                ),
              ),
            ),

            // buttons
            Wrap(
              children: ScreenItems.screenItems
                  .map(
                    (value) => SizedBox(
                  width: value == ScreenItems.number0 ? screenSize.width / 2 : (screenSize.width / 4),
                  height: screenSize.width / 5,
                  child: CustomButton(
                    value: value,
                    onButtonClick: (value) {
                      context.read<CalculationBloc>().onItemTap(value);
                    },
                  ),
                ),
              )
                  .toList(),
            )
          ],
        ),
      ),
    );
  }
}
