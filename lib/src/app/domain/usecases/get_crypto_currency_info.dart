import 'package:crypto_currency_tracker/src/app/domain/entities/crypto_currency.dart';
import 'package:crypto_currency_tracker/src/app/domain/repositories/cyrpto_currency_repository.dart';
import 'package:crypto_currency_tracker/src/app/domain/usecases/params/id_params.dart';
import 'package:crypto_currency_tracker/src/core/error/failure.dart';
import 'package:crypto_currency_tracker/src/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetCryptoCurrencyInfo extends UseCase<CryptoCurrency, IdParams> {
  final CryptoCurrencyRepository repository;

  GetCryptoCurrencyInfo(this.repository);

  @override
  Future<Either<Failure, CryptoCurrency>> call(IdParams params) async {
    return await repository.getCryptoCurrencyInfo(params.id);
  }
}
