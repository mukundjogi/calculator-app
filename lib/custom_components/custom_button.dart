import 'package:calculatorapp/bloc/model/screen_items.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final void Function(String) onButtonClick;
  String value;

  CustomButton({required this.value, super.key, required this.onButtonClick});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: const Border.fromBorderSide(
          BorderSide(
            color: Colors.black,
          ),
        ),
        color: fetchItemColor(value),
      ),
      child: InkWell(
        onTap: () => onButtonClick.call(value),
        child: Center(
          child: Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 28,
            ),
          ),
        ),
      ),
    );
  }

  Color fetchItemColor(String value) {
    switch (value) {
      case ScreenItems.clear:
      case ScreenItems.percentage:
      case ScreenItems.plusminus:
        return Colors.grey.shade900;
      case ScreenItems.multiplication:
      case ScreenItems.addition:
      case ScreenItems.subtract:
      case ScreenItems.division:
      case ScreenItems.equal:
        return Colors.orange.shade400;
      default:
        return Colors.grey.shade800;
    }
  }
}