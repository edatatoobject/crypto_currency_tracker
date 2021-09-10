abstract class CryptoCurrencyLocalDataSource {
  Future<List<String>> getFavoriteCryptoCurrency();

  Future addFavoriteCurrency(String id);

  Future removeFavoriteCurrency(String id);
}
