import 'package:crypto_currency_tracker/src/app/data/datasources/crypto_currency_local_data_source.dart';
import 'package:crypto_currency_tracker/src/app/data/datasources/crypto_currency_remote_data_source.dart';
import 'package:crypto_currency_tracker/src/app/data/models/crypto_currency_model.dart';
import 'package:crypto_currency_tracker/src/app/data/repositories/crypto_currency_repository_impl.dart';
import 'package:crypto_currency_tracker/src/app/data/services/favorite_toggle_service.dart';
import 'package:crypto_currency_tracker/src/app/domain/entities/crypto_currency.dart';
import 'package:crypto_currency_tracker/src/core/error/exception.dart';
import 'package:crypto_currency_tracker/src/core/error/failure.dart';
import 'package:crypto_currency_tracker/src/core/network/network_info.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRemoteDataSource extends Mock
    implements CryptoCurrencyRemoteDataSource {}

class MockLocalDataSource extends Mock
    implements CryptoCurrencyLocalDataSource {}

class MockFavoriteToggleService extends Mock implements FavoriteToggleService {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late CryptoCurrencyRepositoryImpl repository;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockLocalDataSource mockLocalDataSource;
  late MockFavoriteToggleService mockFavoriteToggleService;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockFavoriteToggleService = MockFavoriteToggleService();
    mockNetworkInfo = MockNetworkInfo();
    repository = CryptoCurrencyRepositoryImpl(mockRemoteDataSource,
        mockLocalDataSource, mockFavoriteToggleService, mockNetworkInfo);
  });

  const String id = "bitcoin";

  const CryptoCurrencyModel cryptoCurrencyModel = CryptoCurrencyModel(
      "bitcoin", "Bitcoin", "BTC", "imageUrl", 45000, 1, 1500, 1);

  const List<String> ids = ["bitcoin", "ethereum"];

  const List<CryptoCurrencyModel> cryptoCurrencyModels = [
    CryptoCurrencyModel(
        "bitcoin", "Bitcoin", "BTC", "imageUrl", 45000, 1, 1500, 1.5),
    CryptoCurrencyModel(
        "ethereum", "Ethereum", "ETH", "imageUrl", 3000, 2, 100, 1)
  ];

  const List<CryptoCurrency> unfavoriteCryptoCurrencyModels = [
    CryptoCurrency(
        "bitcoin", "Bitcoin", "BTC", "imageUrl", 45000, 1, 1500, 1.5),
  ];

  const List<CryptoCurrency> favoriteCryptoCurrencyModels = [
    CryptoCurrency(
        "bitcoin", "Bitcoin", "BTC", "imageUrl", 45000, 1, 1500, 1.5, true),
  ];

  test("should check if the device is online", () {
    when(() => mockRemoteDataSource.getCryptoCurrencyInfo(id))
        .thenAnswer((_) async => cryptoCurrencyModel);

    when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    // act
    repository.getCryptoCurrencyInfo(id);
    // assert
    verify(() => mockNetworkInfo.isConnected);
  });

  group("getSingleCryptoCurrency", () {
    test(
        "should return remote data when the call to remote data source is successful",
        () async {
      when(() => mockRemoteDataSource.getCryptoCurrencyInfo(id))
          .thenAnswer((_) async => cryptoCurrencyModel);

      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      final result = await repository.getCryptoCurrencyInfo(id);

      expect(result, equals(const Right(cryptoCurrencyModel)));

      verify(() => mockRemoteDataSource.getCryptoCurrencyInfo(id));
      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test(
      'should return server failure when the call to remote data source is unsuccessful',
      () async {
        when(() => mockRemoteDataSource.getCryptoCurrencyInfo(id))
            .thenThrow(ServerException());

        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);

        final result = await repository.getCryptoCurrencyInfo(id);

        expect(result, equals(Left(ServerFailure())));

        verify(() => mockRemoteDataSource.getCryptoCurrencyInfo(id));
        verifyNoMoreInteractions(mockRemoteDataSource);
      },
    );
  });

  group("getTopCryptoCurrecies", () {
    test(
        "should return remote data when the call to remote data source is successful",
        () async {
      when(() => mockRemoteDataSource.getTopCryptoCurrencies())
          .thenAnswer((_) async => cryptoCurrencyModels);

      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      final result = await repository.getTopCryptoCurrencies();

      expect(result, equals(const Right(cryptoCurrencyModels)));

      verify(() => mockRemoteDataSource.getTopCryptoCurrencies());
      verifyNoMoreInteractions(mockRemoteDataSource);
    });
    test(
      'should return server failure when the call to remote data source is unsuccessful',
      () async {
        when(() => mockRemoteDataSource.getTopCryptoCurrencies())
            .thenThrow(ServerException());

        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);

        final result = await repository.getTopCryptoCurrencies();

        expect(result, equals(Left(ServerFailure())));

        verify(() => mockRemoteDataSource.getTopCryptoCurrencies());
        verifyNoMoreInteractions(mockRemoteDataSource);
      },
    );
  });

  group("getFavoriteCryptoCurrency", () {
    test("should return data from local storage and remote source", () async {
      when(() => mockLocalDataSource.getFavoriteCryptoCurrency())
          .thenAnswer((_) async => ids);

      when(() => mockRemoteDataSource.getCryptoCurrencyArray(ids))
          .thenAnswer((_) async => cryptoCurrencyModels);

      final result = await repository.getFavoriteCryptoCurrencies();

      expect(result, const Right(cryptoCurrencyModels));

      verify(() => mockLocalDataSource.getFavoriteCryptoCurrency());
      verify(() => mockRemoteDataSource.getCryptoCurrencyArray(ids));

      verifyNoMoreInteractions(mockLocalDataSource);
      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test("should return local storage failure on getting favorite", () async {
      when(() => mockLocalDataSource.getFavoriteCryptoCurrency())
          .thenThrow(StorageException());

      final result = await repository.getFavoriteCryptoCurrencies();

      expect(result, Left(StorageFailure()));

      verify(() => mockLocalDataSource.getFavoriteCryptoCurrency());

      verifyNever(() => mockRemoteDataSource.getCryptoCurrencyArray(any()));

      verifyNoMoreInteractions(mockLocalDataSource);
    });

    test("should return remote source failure on getting favorite", () async {
      when(() => mockLocalDataSource.getFavoriteCryptoCurrency())
          .thenAnswer((_) async => ids);

      when(() => mockRemoteDataSource.getCryptoCurrencyArray(ids))
          .thenThrow(ServerException());

      final result = await repository.getFavoriteCryptoCurrencies();

      expect(result, Left(ServerFailure()));

      verify(() => mockLocalDataSource.getFavoriteCryptoCurrency());
      verify(() => mockRemoteDataSource.getCryptoCurrencyArray(ids));

      verifyNoMoreInteractions(mockLocalDataSource);
      verifyNoMoreInteractions(mockRemoteDataSource);
    });
  });

  group("addFavoriteCryptoCurrency", () {
    test("should add new favorite crypto currency", () async {
      when(() => mockLocalDataSource.addFavoriteCurrency(id))
          .thenAnswer((_) async => favoriteCryptoCurrencyModels);

      when(() => mockFavoriteToggleService.setFavorite(
              id, unfavoriteCryptoCurrencyModels))
          .thenReturn(favoriteCryptoCurrencyModels);
      when(() => mockFavoriteToggleService.setFavorite(
              id, unfavoriteCryptoCurrencyModels))
          .thenReturn(favoriteCryptoCurrencyModels);

      var result = await repository.addFavoriteCryptoCurrency(
          id, unfavoriteCryptoCurrencyModels);

      expect(result, Right(favoriteCryptoCurrencyModels));

      verify(() => mockLocalDataSource.addFavoriteCurrency(id));
      verify(() => mockFavoriteToggleService.setFavorite(
          id, unfavoriteCryptoCurrencyModels));

      verifyNoMoreInteractions(mockLocalDataSource);
      verifyNoMoreInteractions(mockFavoriteToggleService);
    });

    test("sould return local storege failure on adding to favorite", () async {
      when(() => mockLocalDataSource.addFavoriteCurrency(id))
          .thenThrow(StorageException());

      var result = await repository.addFavoriteCryptoCurrency(
          id, favoriteCryptoCurrencyModels);

      expect(result, equals(Left(StorageFailure())));

      verify(() => mockLocalDataSource.addFavoriteCurrency(id));

      verifyNoMoreInteractions(mockLocalDataSource);
    });
  });

  group("removeFavoriteCryptoCurrency", () {
    test("should remove favorite crypto currency", () async {
      when(() => mockLocalDataSource.removeFavoriteCurrency(id))
          .thenAnswer((_) async => null);

      when(() => mockFavoriteToggleService.unsetFavorite(
              id, favoriteCryptoCurrencyModels))
          .thenReturn(unfavoriteCryptoCurrencyModels);

      var result = await repository.removeFavoriteCryptoCurrency(
          id, favoriteCryptoCurrencyModels);

      expect(result, Right(unfavoriteCryptoCurrencyModels));

      verify(() => mockLocalDataSource.removeFavoriteCurrency(id));
      verify(() => mockFavoriteToggleService.unsetFavorite(
          id, favoriteCryptoCurrencyModels));

      verifyNoMoreInteractions(mockLocalDataSource);
      verifyNoMoreInteractions(mockFavoriteToggleService);
    });

    test("sould return local storege failure on removing from favorite",
        () async {
      when(() => mockLocalDataSource.removeFavoriteCurrency(id))
          .thenThrow(StorageException());

      var result = await repository.removeFavoriteCryptoCurrency(
          id, favoriteCryptoCurrencyModels);

      expect(result, equals(Left(StorageFailure())));

      verify(() => mockLocalDataSource.removeFavoriteCurrency(id));

      verifyNoMoreInteractions(mockLocalDataSource);
    });
  });
}
