import 'package:crypto_currency_tracker/src/app/domain/entities/crypto_coin.dart';

class CryptoCoinModel extends CryptoCoin {
  const CryptoCoinModel(String id, String name, String symbol, String imageUrl,
      double price, int ranc, double priceChange, double pricaChangePersentage)
      : super(id, name, symbol, imageUrl, price, ranc, priceChange,
            pricaChangePersentage);

  factory CryptoCoinModel.fromJson(Map<String, dynamic> json) {
    return CryptoCoinModel(
        json["id"],
        json["name"],
        (json["symbol"] as String).toUpperCase(),
        json["image"],
        (json["current_price"] as num).toDouble(),
        json["market_cap_rank"],
        (json["price_change_24h"] as num).toDouble(),
        (json["price_change_percentage_24h"] as num).toDouble());
  }
}
