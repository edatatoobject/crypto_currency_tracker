import 'dart:io';

import 'package:crypto_currency_tracker/src/app/data/datasources/crypto_currency_remote_data_source.dart';
import 'package:crypto_currency_tracker/src/app/data/models/crypto_currency_model.dart';
import 'package:crypto_currency_tracker/src/core/error/exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements Client {}

void main() {
  late CryptoCurrencyRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = CryptoCurrencyRemoteDataSourceImpl(mockHttpClient);
  });

  final topCryptoCurrencyUrl = Uri.parse(
      "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&per_page=20");
  final cryptoCurrencyArrayInfoUrl = Uri.parse(
      "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&ids=bitcoin,ethereum");

  const id = "bitcoin";
  const List<String> ids = ["bitcoin", "ethereum"];

  const CryptoCurrencyModel cryptoCurrencyModel = CryptoCurrencyModel(
      "bitcoin", "Bitcoin", "BTC", "imageUrl", 45000, 1, 1500, 1);
  const List<CryptoCurrencyModel> cryptoCurrencyModels = [
    CryptoCurrencyModel(
        "bitcoin", "Bitcoin", "BTC", "imageUrl", 45000, 1, 1500, 1),
    CryptoCurrencyModel(
        "ethereum", "Ethereum", "ETH", "imageUrl", 3000, 2, 100, 1)
  ];

  group("getCryptoCurrencyArray", () {
    test("should return array of crypto currencies fetched from server",
        () async {
      when(() => mockHttpClient.get(topCryptoCurrencyUrl)).thenAnswer(
          (_) async =>
              Response(fixture("crypto_currencies.json"), HttpStatus.ok));

      var result = await dataSource.getTopCryptoCurrencies();

      expect(result, cryptoCurrencyModels);

      verify(() => mockHttpClient.get(topCryptoCurrencyUrl));
    });

    test("should throw server excepiton on error status code", () async {
      when(() => mockHttpClient.get(topCryptoCurrencyUrl))
          .thenAnswer((_) async => Response("", HttpStatus.badRequest));

      expect(() async => await dataSource.getTopCryptoCurrencies(),
          throwsA(const TypeMatcher<ServerException>()));

      verify(() => mockHttpClient.get(topCryptoCurrencyUrl));
    });
  });

  group("getCryptoCurrencyArray", () {
    test("should return array of crypto currency", () async {
      when(() => mockHttpClient.get(cryptoCurrencyArrayInfoUrl)).thenAnswer(
          (_) async =>
              Response(fixture("crypto_currencies.json"), HttpStatus.ok));

      var result = await dataSource.getCryptoCurrencyArray(ids);

      expect(result, cryptoCurrencyModels);

      verify(() => mockHttpClient.get(cryptoCurrencyArrayInfoUrl));
    });

    test("should throw exception on fetching info", () async {
      when(() => mockHttpClient.get(cryptoCurrencyArrayInfoUrl))
          .thenAnswer((_) async => Response("", HttpStatus.badRequest));

      expect(() async => await dataSource.getCryptoCurrencyArray(ids),
          throwsA(const TypeMatcher<ServerException>()));

      verify(() => mockHttpClient.get(cryptoCurrencyArrayInfoUrl));
    });
  });
}
