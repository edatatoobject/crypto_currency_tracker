import 'package:crypto_currency_tracker/src/app/domain/entities/crypto_currency.dart';

class CryptoCurrencyModel extends CryptoCurrency {
  const CryptoCurrencyModel(String id, String name, String symbol, String imageUrl,
      double price, int ranc, double priceChange, double pricaChangePersentage, [bool favorite = false])
      : super(id, name, symbol, imageUrl, price, ranc, priceChange,
            pricaChangePersentage, favorite);

  factory CryptoCurrencyModel.fromJson(Map<String, dynamic> json) {
    return CryptoCurrencyModel(
        json["id"],
        json["name"],
        (json["symbol"] as String).toUpperCase(),
        json["image"],
        (json["current_price"] as num).toDouble(),
        json["market_cap_rank"],
        (json["price_change_24h"] as num).toDouble(),
        (json["price_change_percentage_24h"] as num).toDouble());
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
        "name": name,
        "symbol": symbol.toLowerCase(),
        "image": imageUrl,
        "current_price": price,
        "market_cap_rank": ranc,
        "price_change_24h": priceChange,
        "price_change_percentage_24h": pricaChangePersentage
    };
  }
}
