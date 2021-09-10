import 'package:crypto_currency_tracker/src/app/domain/entities/crypto_currency.dart';
import 'package:crypto_currency_tracker/src/app/domain/repositories/cyrpto_currency_repository.dart';
import 'package:crypto_currency_tracker/src/core/error/failure.dart';
import 'package:crypto_currency_tracker/src/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetCryptoCurrencyInfo extends UseCase<CryptoCurrency, Params> {
  final CryptoCurrencyRepository repository;

  GetCryptoCurrencyInfo(this.repository);

  @override
  Future<Either<Failure, CryptoCurrency>> call(Params params) async {
    return await repository.getCryptoCurrencyInfo(params.id);
  }
}

class Params extends Equatable {
  final String id;

  const Params({required this.id}) : super();

  @override
  List<Object?> get props => [id];
}
