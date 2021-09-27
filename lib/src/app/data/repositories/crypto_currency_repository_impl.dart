import 'package:crypto_currency_tracker/src/app/data/datasources/crypto_currency_local_data_source.dart';
import 'package:crypto_currency_tracker/src/app/data/datasources/crypto_currency_remote_data_source.dart';
import 'package:crypto_currency_tracker/src/app/data/services/favorite_toggle_service.dart';
import 'package:crypto_currency_tracker/src/app/domain/entities/crypto_currency.dart';
import 'package:crypto_currency_tracker/src/app/domain/repositories/cyrpto_currency_repository.dart';
import 'package:crypto_currency_tracker/src/core/error/exception.dart';
import 'package:crypto_currency_tracker/src/core/network/network_info.dart';
import 'package:dartz/dartz.dart';
import 'package:crypto_currency_tracker/src/core/error/failure.dart';

class CryptoCurrencyRepositoryImpl implements CryptoCurrencyRepository {
  final CryptoCurrencyRemoteDataSource remoteDataSource;
  final CryptoCurrencyLocalDataSource localDataSource;
  final FavoriteToggleService favoriteToggleService;
  final NetworkInfo networkInfo;

  CryptoCurrencyRepositoryImpl(this.remoteDataSource, this.localDataSource,
      this.favoriteToggleService, this.networkInfo);

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
  Future<Either<Failure, List<CryptoCurrency>>>
      getFavoriteCryptoCurrencies() async {
    List<String> favoriteIds = [];
    try {
      favoriteIds = await localDataSource.getFavoriteCryptoCurrency();
    } on StorageException {
      return Left(StorageFailure());
    }

    if (favoriteIds.isEmpty) {
      return Right([]);
    }

    try {
      return Right(await remoteDataSource.getCryptoCurrencyArray(favoriteIds));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<CryptoCurrency>>> addFavoriteCryptoCurrency(
      String id, List<CryptoCurrency> cryptoCurrencies) async {
    try {
      await localDataSource.addFavoriteCurrency(id);
    } on StorageException {
      return Left(StorageFailure());
    }

    var newFavoriteCryptoCurrencies =
        favoriteToggleService.setFavorite(id, cryptoCurrencies);

    return Right(newFavoriteCryptoCurrencies);
  }

  @override
  Future<Either<Failure, List<CryptoCurrency>>> removeFavoriteCryptoCurrency(
      String id, List<CryptoCurrency> cryptoCurrencies) async {
    try {
      await localDataSource.removeFavoriteCurrency(id);
    } on StorageException {
      return Left(StorageFailure());
    }

    var newFavoriteCryptoCurrencies =
        favoriteToggleService.unsetFavorite(id, cryptoCurrencies);

    return Right(newFavoriteCryptoCurrencies);
  }
}
