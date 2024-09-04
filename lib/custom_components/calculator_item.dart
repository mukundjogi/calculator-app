import 'package:flutter/material.dart';

class CalculatorItem extends StatelessWidget {
  int index;
   CalculatorItem(this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child:  Center(child: Text(index.toString(),style: const TextStyle(color: Colors.white),),),
    );
  }
}
