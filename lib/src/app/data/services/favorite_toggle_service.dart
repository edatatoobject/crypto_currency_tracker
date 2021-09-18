import 'package:crypto_currency_tracker/src/app/domain/entities/crypto_currency.dart';

class FavoriteToggleService {
  List<CryptoCurrency> setFavorite(
      String id, List<CryptoCurrency> cryptoCurrencies) {
    var itemIndex = cryptoCurrencies.indexWhere((element) => element.id == id);

    cryptoCurrencies[itemIndex] =
        _recreateModel(cryptoCurrencies[itemIndex], true);

    return cryptoCurrencies;
  }

  List<CryptoCurrency> unsetFavorite(
      String id, List<CryptoCurrency> cryptoCurrencies) {
    var itemIndex = cryptoCurrencies.indexWhere((element) => element.id == id);

    cryptoCurrencies[itemIndex] =
        _recreateModel(cryptoCurrencies[itemIndex], false);

    return cryptoCurrencies;
  }

  CryptoCurrency _recreateModel(CryptoCurrency model, bool favorite) {
    return CryptoCurrency(
        model.id,
        model.name,
        model.symbol,
        model.imageUrl,
        model.price,
        model.ranc,
        model.priceChange,
        model.pricaChangePersentage,
        favorite);
  }
}
