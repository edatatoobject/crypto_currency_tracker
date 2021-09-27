import 'package:crypto_currency_tracker/src/app/domain/repositories/cyrpto_currency_repository.dart';
import 'package:crypto_currency_tracker/src/app/domain/usecases/params/id_params.dart';
import 'package:crypto_currency_tracker/src/core/error/failure.dart';
import 'package:crypto_currency_tracker/src/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

class AddFavoriteCryptoCurrency extends UseCaseWithNoReturn<IdParams> {
  final CryptoCurrencyRepository repository;

  AddFavoriteCryptoCurrency(this.repository);

  @override
  Future<Either<Failure, NoReturn>> call(IdParams params) async {
    return await repository.addFavoriteCryptoCurrency(params.id);
  }
}
