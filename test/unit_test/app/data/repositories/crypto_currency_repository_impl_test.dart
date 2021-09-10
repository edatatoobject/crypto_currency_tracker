import 'package:crypto_currency_tracker/src/app/data/datasources/crypto_currency_local_data_source.dart';
import 'package:crypto_currency_tracker/src/app/data/datasources/crypto_currency_remote_data_source.dart';
import 'package:crypto_currency_tracker/src/app/data/models/crypto_currency_model.dart';
import 'package:crypto_currency_tracker/src/app/data/repositories/crypto_currency_repository_impl.dart';
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

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late CryptoCurrencyRepositoryImpl repository;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = CryptoCurrencyRepositoryImpl(
      mockRemoteDataSource,
      mockLocalDataSource,
      mockNetworkInfo,
    );
  });

  const String id = "bitcoin";
  const CryptoCurrencyModel cryptoCurrencyModel = CryptoCurrencyModel(
      "bitcoin", "Bitcoin", "BTC", "imageUrl", 45000, 1, 1500, 1);
  const CryptoCurrency cryptoCurrency = cryptoCurrencyModel;

  const topCryptoCurrencyModels = [
    CryptoCurrencyModel(
        "bitcoin", "Bitcoin", "BTC", "imageUrl", 45000, 1, 1500, 1.5),
    CryptoCurrencyModel(
        "ethereum", "Ethereum", "ETH", "imageUrl", 3000, 2, 100, 1)
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
  group("get single crypto currency", () {
    test(
        "should return remote data when the call to remote data source is successful",
        () async {
      when(() => mockRemoteDataSource.getCryptoCurrencyInfo(id))
          .thenAnswer((_) async => cryptoCurrencyModel);

      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      final result = await repository.getCryptoCurrencyInfo(id);

      verify(() => mockRemoteDataSource.getCryptoCurrencyInfo(id));
      expect(result, equals(const Right(cryptoCurrencyModel)));
    });

    test(
      'should return server failure when the call to remote data source is unsuccessful',
      () async {
        when(() => mockRemoteDataSource.getCryptoCurrencyInfo(id))
            .thenThrow(ServerException());

        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);

        final result = await repository.getCryptoCurrencyInfo(id);

        verify(() => mockRemoteDataSource.getCryptoCurrencyInfo(id));

        expect(result, equals(Left(ServerFailure())));
      },
    );
  });

  group("get top crypto currencies", () {
    test(
        "should return remote data when the call to remote data source is successful",
        () async {
      when(() => mockRemoteDataSource.getTopCryptoCurrencies())
          .thenAnswer((_) async => topCryptoCurrencyModels);

      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      final result = await repository.getTopCryptoCurrencies();

      verify(() => mockRemoteDataSource.getTopCryptoCurrencies());
      expect(result, equals(const Right(topCryptoCurrencyModels)));
    });
    test(
      'should return server failure when the call to remote data source is unsuccessful',
      () async {
        when(() => mockRemoteDataSource.getTopCryptoCurrencies())
            .thenThrow(ServerException());

        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);

        final result = await repository.getTopCryptoCurrencies();

        verify(() => mockRemoteDataSource.getTopCryptoCurrencies());

        expect(result, equals(Left(ServerFailure())));
      },
    );
  });
}
