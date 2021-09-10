import 'package:crypto_currency_tracker/src/app/domain/entities/crypto_currency.dart';
import 'package:crypto_currency_tracker/src/app/domain/repositories/cyrpto_currency_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:crypto_currency_tracker/src/core/error/failure.dart';

class CryptoCurrencyRepositoryImpl implements CryptoCurrencyRepository{
  @override
  Future<Either<Failure, CryptoCurrency>> getCryptoCurrencyInfo(String id) {
    // TODO: implement getCryptoCoinInfo
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<CryptoCurrency>>> getTopCryptoCurrencies() {
    // TODO: implement getTopCryptoCoins
    throw UnimplementedError();
  }

}