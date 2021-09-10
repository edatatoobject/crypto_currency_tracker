import 'package:equatable/equatable.dart';

class CryptoCoin extends Equatable {
  final String id;
  final String name;
  final String symbol;
  final String imageUrl;
  final double price;
  final int ranc;
  final double priceChange;
  final double pricaChangePersentage;

  const CryptoCoin(this.id, this.name, this.symbol, this.imageUrl, this.price, this.ranc,
      this.priceChange, this.pricaChangePersentage);

  @override
  List<Object> get props =>
      [price, priceChange, pricaChangePersentage, imageUrl];
}
