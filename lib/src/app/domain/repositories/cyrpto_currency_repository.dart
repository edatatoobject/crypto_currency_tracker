import 'package:crypto_currency_tracker/src/app/domain/entities/crypto_currency.dart';
import 'package:crypto_currency_tracker/src/core/error/failure.dart';
import 'package:crypto_currency_tracker/src/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

abstract class CryptoCurrencyRepository {
  Future<Either<Failure, CryptoCurrency>> getCryptoCurrencyInfo(String id);
  Future<Either<Failure, List<CryptoCurrency>>> getTopCryptoCurrencies();
  Future<Either<Failure, List<CryptoCurrency>>> getFavoriteCryptoCurrencies();
  Future<Either<Failure, NoReturn>> addFavoriteCryptoCurrency(String id);
  Future<Either<Failure, NoReturn>> removeFavoriteCryptoCurrency(String id);
}
