import 'package:crypto_currency_tracker/src/app/domain/entities/crypto_coin.dart';
import 'package:crypto_currency_tracker/src/app/domain/repositories/cyrpto_coin_repository.dart';
import 'package:crypto_currency_tracker/src/core/error/failure.dart';
import 'package:crypto_currency_tracker/src/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

class GetTopCryptoCoins extends UseCase<List<CryptoCoin>, NoParams> {
  final CryptoCoinRepository repository;

  GetTopCryptoCoins(this.repository);

  @override
  Future<Either<Failure, List<CryptoCoin>>> call(NoParams params) async {
    return await repository.getTopCryptoCoins();
  }
}
