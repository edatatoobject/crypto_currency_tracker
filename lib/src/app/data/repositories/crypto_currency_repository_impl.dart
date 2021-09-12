import 'package:crypto_currency_tracker/src/app/data/datasources/crypto_currency_local_data_source.dart';
import 'package:crypto_currency_tracker/src/app/data/datasources/crypto_currency_remote_data_source.dart';
import 'package:crypto_currency_tracker/src/app/domain/entities/crypto_currency.dart';
import 'package:crypto_currency_tracker/src/app/domain/repositories/cyrpto_currency_repository.dart';
import 'package:crypto_currency_tracker/src/core/error/exception.dart';
import 'package:crypto_currency_tracker/src/core/network/network_info.dart';
import 'package:crypto_currency_tracker/src/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:crypto_currency_tracker/src/core/error/failure.dart';

class CryptoCurrencyRepositoryImpl implements CryptoCurrencyRepository {
  final CryptoCurrencyRemoteDataSource remoteDataSource;
  final CryptoCurrencyLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  CryptoCurrencyRepositoryImpl(
      this.remoteDataSource, this.localDataSource, this.networkInfo);

  @override
  Future<Either<Failure, CryptoCurrency>> getCryptoCurrencyInfo(
      String id) async {
    networkInfo.isConnected;
    try {
      return Right(await remoteDataSource.getCryptoCurrencyInfo(id));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<CryptoCurrency>>> getTopCryptoCurrencies() async {
    networkInfo.isConnected;
    try {
      return Right(await remoteDataSource.getTopCryptoCurrencies());
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<CryptoCurrency>>> getFavoriteCryptoCurrencies() {
    // TODO: implement getFavoriteCryptoCurrencies
    throw UnimplementedError();
  }

    @override
  Future<Either<Failure, NoReturn>> addFavoriteCryptoCurrency(String id) {
    // TODO: implement addFavoriteCryptoCurrency
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, NoReturn>> removeFavoriteCryptoCurrency(String id) {
    // TODO: implement removeFavoriteCryptoCurrency
    throw UnimplementedError();
  }
}
