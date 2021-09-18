import 'package:crypto_currency_tracker/src/app/domain/entities/crypto_currency.dart';
import 'package:crypto_currency_tracker/src/app/presentation/widgets/ui_elements/price_color.dart';
import 'package:flutter/material.dart';

class CryptoCurrencyListItem extends StatelessWidget {
  final CryptoCurrency cryptoCurrency;
  const CryptoCurrencyListItem(this.cryptoCurrency, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Image.network(cryptoCurrency.imageUrl, width: 50, height: 50,),
              SizedBox(
                width: 20,
              ),
              Column(
                children: [
                  Text(cryptoCurrency.name),
                  Text(cryptoCurrency.symbol)
                ],
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                children: [
                  Text(cryptoCurrency.price.toString()),
                  PriceText(cryptoCurrency.pricaChangePersentage),
                ],
              )
            ],
          ),
        )
        
        );
  }
}
