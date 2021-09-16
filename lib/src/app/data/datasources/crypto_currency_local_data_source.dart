import 'package:crypto_currency_tracker/src/core/error/exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class CryptoCurrencyLocalDataSource {
  Future<List<String>> getFavoriteCryptoCurrency();

  Future addFavoriteCurrency(String id);

  Future removeFavoriteCurrency(String id);
}

class CryptoCurrencyLocalDataSourceImpl extends CryptoCurrencyLocalDataSource {
  static const favoriteProperty = "favotire";

  final SharedPreferences sharedPreferences;

  CryptoCurrencyLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<List<String>> getFavoriteCryptoCurrency() {
    final favoriteList = sharedPreferences.getStringList(favoriteProperty);

    if (favoriteList != null) {
      return Future.value(favoriteList);
    }

    return Future.value([]);
  }

  //TODO: add should thorow StorageException if id is already in favorite
  @override
  Future addFavoriteCurrency(String id) async {
    final favoriteList = sharedPreferences.getStringList(favoriteProperty);
    List<String> newFavoriteList = [];

    if (favoriteList != null) {
      newFavoriteList = [...favoriteList];
      if (!newFavoriteList.contains(id)) {
        newFavoriteList.add(id);
      }
    } else {
      newFavoriteList.add(id);
    }

    var result = await sharedPreferences.setStringList(
        favoriteProperty, newFavoriteList);

    if (!result) {
      throw StorageException();
    }

    return;
  }

  //TODO: must return StorageException if removing id not in favorites
  @override
  Future removeFavoriteCurrency(String id) async {
    final favoriteList = sharedPreferences.getStringList(favoriteProperty);

    if (favoriteList == null) {
      return;
    }

    var newFavoriteList = [...favoriteList];

    if (!newFavoriteList.contains(id)) {
      return;
    }

    newFavoriteList.remove(id);

    var result = await sharedPreferences.setStringList(
        favoriteProperty, newFavoriteList);

    if (!result) {
      throw StorageException();
    }

    return;
  }
}
