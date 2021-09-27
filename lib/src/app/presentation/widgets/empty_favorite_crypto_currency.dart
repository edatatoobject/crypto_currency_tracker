import 'package:flutter/widgets.dart';

class EmptyFavoriteCryptoCurrency extends StatelessWidget {
  const EmptyFavoriteCryptoCurrency({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("You have no favorite coins yet!"),);
  }
}