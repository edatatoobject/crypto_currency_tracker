import 'package:crypto_currency_tracker/src/app/domain/entities/crypto_currency.dart';
import 'package:crypto_currency_tracker/src/app/presentation/widgets/ui_elements/favorite_icon_button.dart';
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
              Image.network(cryptoCurrency.imageUrl, width: 60, height: 60,),
              SizedBox(
                width: 20,
              ),
              Column(
                children: [
                  Text(cryptoCurrency.name, style: TextStyle(fontSize: 20),),
                  Text(cryptoCurrency.symbol, style: TextStyle(fontSize: 16, color: Colors.blueGrey),)
                ],
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                children: [
                  Text("${cryptoCurrency.price.toString()}\$", style: TextStyle(fontSize: 18),),
                  PriceText(cryptoCurrency.pricaChangePersentage),
                ],
              ),
              Spacer(),
              FavoriteIconButton(cryptoCurrency.id, cryptoCurrency.favorite)
            ],
          ),
        )
        
        );
  }
}
