import 'package:crypto_currency_tracker/src/app/data/datasources/crypto_currency_local_data_source.dart';
import 'package:crypto_currency_tracker/src/app/data/datasources/crypto_currency_remote_data_source.dart';
import 'package:crypto_currency_tracker/src/app/data/services/favorite_model_service.dart';
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
  final FavotireModelService favotireModelService;
  final NetworkInfo networkInfo;

  CryptoCurrencyRepositoryImpl(this.remoteDataSource, this.localDataSource,
      this.favotireModelService, this.networkInfo);

  @override
  Future<Either<Failure, List<CryptoCurrency>>> getTopCryptoCurrencies() async {
    networkInfo.isConnected;
    try {
      var topCryptoCurrencies = await remoteDataSource.getTopCryptoCurrencies();

      var favoriteIds = await localDataSource.getFavoriteCryptoCurrency();

      return Right(favotireModelService.checkFavoriteModels(
          topCryptoCurrencies, favoriteIds));
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
      return Right(favotireModelService.setAllFavorite(
          await remoteDataSource.getCryptoCurrencyArray(favoriteIds)));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, NoReturn>> addFavoriteCryptoCurrency(
      String id) async {
    try {
      await localDataSource.addFavoriteCurrency(id);
    } on StorageException {
      return Left(StorageFailure());
    }

    return Right(NoReturn());
  }

  @override
  Future<Either<Failure, NoReturn>> removeFavoriteCryptoCurrency(
      String id) async {
    try {
      await localDataSource.removeFavoriteCurrency(id);
    } on StorageException {
      return Left(StorageFailure());
    }

    return Right(NoReturn());
  }
}
