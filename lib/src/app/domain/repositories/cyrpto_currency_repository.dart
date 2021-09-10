import 'package:crypto_currency_tracker/src/app/domain/entities/crypto_currency.dart';
import 'package:crypto_currency_tracker/src/core/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class CryptoCurrencyRepository {
  Future<Either<Failure, CryptoCurrency>> getCryptoCurrencyInfo(String id);
  Future<Either<Failure, List<CryptoCurrency>>> getTopCryptoCurrencies();
}
