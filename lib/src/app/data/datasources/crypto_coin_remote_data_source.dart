import 'package:crypto_currency_tracker/src/app/domain/entities/crypto_currency.dart';

abstract class CryptoCurrencyRemoteDataSource {


  Future<CryptoCurrency> getCryptoCurrencyInfo(String id);

  /// Calls the https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<CryptoCurrency>> getTopCryptoCurrencies();
}
