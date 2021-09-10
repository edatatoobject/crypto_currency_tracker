import 'package:crypto_currency_tracker/src/app/data/models/crypto_currency_model.dart';

abstract class CryptoCurrencyRemoteDataSource {



  Future<CryptoCurrencyModel> getCryptoCurrencyInfo(String id);

  /// Calls the https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<CryptoCurrencyModel>> getTopCryptoCurrencies();
}
