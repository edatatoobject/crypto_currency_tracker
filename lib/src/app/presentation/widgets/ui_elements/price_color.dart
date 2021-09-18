import 'package:flutter/material.dart';

class PriceText extends StatelessWidget {
  final double price;
  const PriceText(this.price, {Key? key = null}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(price.toString(), style: TextStyle(color: price >= 0 ? Colors.green : Colors.red));
  }
}
