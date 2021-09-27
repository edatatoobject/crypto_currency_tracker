import 'package:crypto_currency_tracker/src/app/domain/entities/crypto_currency.dart';

class FavotireModelService {
  List<CryptoCurrency> checkFavoriteModels(
      List<CryptoCurrency> cryptoCurrencies, List<String> favoriteIds) {
    if (favoriteIds.isEmpty) return cryptoCurrencies;

    return cryptoCurrencies
        .map((e) => CryptoCurrency(
            e.id,
            e.name,
            e.symbol,
            e.imageUrl,
            e.price,
            e.ranc,
            e.priceChange,
            e.pricaChangePersentage,
            favoriteIds.contains(e.id)))
        .toList();
  }

  List<CryptoCurrency> setAllFavorite(List<CryptoCurrency> cryptoCurrencies) {
    return cryptoCurrencies
        .map((e) => CryptoCurrency(
              e.id,
              e.name,
              e.symbol,
              e.imageUrl,
              e.price,
              e.ranc,
              e.priceChange,
              e.pricaChangePersentage,
              true,
            ))
        .toList();
  }
}
