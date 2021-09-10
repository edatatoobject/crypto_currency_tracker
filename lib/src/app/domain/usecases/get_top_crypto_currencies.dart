import 'package:crypto_currency_tracker/src/app/domain/entities/crypto_currency.dart';
import 'package:crypto_currency_tracker/src/app/domain/repositories/cyrpto_currency_repository.dart';
import 'package:crypto_currency_tracker/src/core/error/failure.dart';
import 'package:crypto_currency_tracker/src/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

class GetTopCryptoCurrencies extends UseCase<List<CryptoCurrency>, NoParams> {
  final CryptoCurrencyRepository repository;

  GetTopCryptoCurrencies(this.repository);

  @override
  Future<Either<Failure, List<CryptoCurrency>>> call(NoParams params) async {
    return await repository.getTopCryptoCurrencies();
  }
}
