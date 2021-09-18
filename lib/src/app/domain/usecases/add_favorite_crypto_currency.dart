import 'package:crypto_currency_tracker/src/app/domain/entities/crypto_currency.dart';
import 'package:crypto_currency_tracker/src/app/domain/repositories/cyrpto_currency_repository.dart';
import 'package:crypto_currency_tracker/src/app/domain/usecases/params/id_and_crypto_currencies_params.dart';
import 'package:crypto_currency_tracker/src/core/error/failure.dart';
import 'package:crypto_currency_tracker/src/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

class AddFavoriteCryptoCurrency extends UseCase<List<CryptoCurrency>, IdAndCryptoCurrenciesParams> {
  final CryptoCurrencyRepository repository;

  AddFavoriteCryptoCurrency(this.repository);

  @override
  Future<Either<Failure, List<CryptoCurrency>>> call(IdAndCryptoCurrenciesParams params) async {
    return await repository.addFavoriteCryptoCurrency(params.id, params.cryptoCurrencies);
  }
}
