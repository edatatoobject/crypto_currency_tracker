import 'package:crypto_currency_tracker/src/app/data/models/crypto_currency_model.dart';
import 'package:http/http.dart';

abstract class CryptoCurrencyRemoteDataSource {
  Future<CryptoCurrencyModel> getCryptoCurrencyInfo(String id);

  Future<List<CryptoCurrencyModel>> getCryptoCurrencyArray(List<String> ids);

  Future<List<CryptoCurrencyModel>> getTopCryptoCurrencies();
}

class CryptoCurrencyRemoteDataSourceImpl
    implements CryptoCurrencyRemoteDataSource {
  static const url =
      "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd";

  final Client httpClient;

  CryptoCurrencyRemoteDataSourceImpl(this.httpClient);

  @override
  Future<List<CryptoCurrencyModel>> getCryptoCurrencyArray(List<String> ids) {
    // TODO: implement getCryptoCurrencyArray
    throw UnimplementedError();
  }

  @override
  Future<CryptoCurrencyModel> getCryptoCurrencyInfo(String id) {
    // TODO: implement getCryptoCurrencyInfo
    throw UnimplementedError();
  }

  @override
  Future<List<CryptoCurrencyModel>> getTopCryptoCurrencies() {
    // TODO: implement getTopCryptoCurrencies
    throw UnimplementedError();
  }
}
