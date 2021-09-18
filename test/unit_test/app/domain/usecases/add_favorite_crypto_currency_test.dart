import 'package:crypto_currency_tracker/src/app/domain/entities/crypto_currency.dart';
import 'package:crypto_currency_tracker/src/app/domain/repositories/cyrpto_currency_repository.dart';
import 'package:crypto_currency_tracker/src/app/domain/usecases/add_favorite_crypto_currency.dart';
import 'package:crypto_currency_tracker/src/app/domain/usecases/params/id_and_crypto_currencies_params.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCryptoCurrencyRepository extends Mock
    implements CryptoCurrencyRepository {}

void main() {
  late AddFavoriteCryptoCurrency usecase;
  late MockCryptoCurrencyRepository mockCryptoCurrencyRepository;

  setUp(() {
    mockCryptoCurrencyRepository = MockCryptoCurrencyRepository();
    usecase = AddFavoriteCryptoCurrency(mockCryptoCurrencyRepository);
  });

  const id = "bitcoin";
  const List<CryptoCurrency> cryptoCurrencies = [
    CryptoCurrency(
        "bitcoin", "Bitcoin", "BTC", "imageUrl", 45000, 1, 1500, 1.5),
  ];

  const List<CryptoCurrency> favoriteCryptoCurrencys = [
    CryptoCurrency(
        "bitcoin", "Bitcoin", "BTC", "imageUrl", 45000, 1, 1500, 1.5, true),
  ];

  test("should add crypto currency to favorites", () async {
    when(() => mockCryptoCurrencyRepository.addFavoriteCryptoCurrency(
            id, cryptoCurrencies))
        .thenAnswer((_) async => Right(favoriteCryptoCurrencys));

    var result = await usecase(const IdAndCryptoCurrenciesParams(
        id: id, cryptoCurrencies: cryptoCurrencies));

    expect(result, Right(favoriteCryptoCurrencys));

    verify(() => mockCryptoCurrencyRepository.addFavoriteCryptoCurrency(id, cryptoCurrencies));
    verifyNoMoreInteractions(mockCryptoCurrencyRepository);
  });
}
