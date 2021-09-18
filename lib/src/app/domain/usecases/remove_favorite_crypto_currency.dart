import 'package:crypto_currency_tracker/src/app/domain/entities/crypto_currency.dart';
import 'package:crypto_currency_tracker/src/app/domain/repositories/cyrpto_currency_repository.dart';
import 'package:crypto_currency_tracker/src/app/domain/usecases/params/id_and_crypto_currencies_params.dart';
import 'package:crypto_currency_tracker/src/core/error/failure.dart';
import 'package:crypto_currency_tracker/src/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

class RemoveFavoriteCryptoCurrency implements UseCase<List<CryptoCurrency>, IdAndCryptoCurrenciesParams> {
  final CryptoCurrencyRepository repository;

  RemoveFavoriteCryptoCurrency(this.repository);

  @override
  Future<Either<Failure, List<CryptoCurrency>>> call(params) async {
    return await repository.removeFavoriteCryptoCurrency(params.id, params.cryptoCurrencies);
  }
}
