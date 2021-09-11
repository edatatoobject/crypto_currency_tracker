import 'package:crypto_currency_tracker/src/core/error/failure.dart';
import 'package:crypto_currency_tracker/src/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

class RemoveFavoriteCryptoCurrency implements UseCaseWithNoReturn {
  @override
  Future<Either<Failure, NoReturn>> call(params) {
    // TODO: implement call
    throw UnimplementedError();
  }

}