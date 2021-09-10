import 'package:crypto_currency_tracker/src/app/domain/entities/crypto_coin.dart';
import 'package:crypto_currency_tracker/src/core/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class CryptoCoinRepository {
  Future<Either<Failure, CryptoCoin>> getCryptoCoinInfo(String id);
  Future<Either<Failure, List<CryptoCoin>>> getTopCryptoCoins();
}
