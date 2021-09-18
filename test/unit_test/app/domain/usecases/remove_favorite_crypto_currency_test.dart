import 'package:crypto_currency_tracker/src/app/domain/entities/crypto_currency.dart';
import 'package:crypto_currency_tracker/src/app/domain/repositories/cyrpto_currency_repository.dart';
import 'package:crypto_currency_tracker/src/app/domain/usecases/params/id_and_crypto_currencies_params.dart';
import 'package:crypto_currency_tracker/src/app/domain/usecases/remove_favorite_crypto_currency.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCryptoCurrencyRepository extends Mock
    implements CryptoCurrencyRepository {}

void main() {
  late RemoveFavoriteCryptoCurrency usecase;
  late MockCryptoCurrencyRepository mockCryptoCurrencyRepository;

  setUp(() {
    mockCryptoCurrencyRepository = MockCryptoCurrencyRepository();
    usecase = RemoveFavoriteCryptoCurrency(mockCryptoCurrencyRepository);
  });

  const id = "bitcoin";
  const List<CryptoCurrency> favoriteCryptoCurrencys = [
    CryptoCurrency(
        "bitcoin", "Bitcoin", "BTC", "imageUrl", 45000, 1, 1500, 1.5, true),
  ];
  const List<CryptoCurrency> CryptoCurrencys = [
    CryptoCurrency(
        "bitcoin", "Bitcoin", "BTC", "imageUrl", 45000, 1, 1500, 1.5),
  ];

  test("should remove crypto currency from favorites", () async {
    when(() => mockCryptoCurrencyRepository.removeFavoriteCryptoCurrency(
            id, favoriteCryptoCurrencys))
        .thenAnswer((_) async => Right(CryptoCurrencys));

    var result = await usecase(const IdAndCryptoCurrenciesParams(
        id: id, cryptoCurrencies: favoriteCryptoCurrencys));

    expect(result, Right(CryptoCurrencys));

    verify(() => mockCryptoCurrencyRepository.removeFavoriteCryptoCurrency(
        id, CryptoCurrencys));
    verifyNoMoreInteractions(mockCryptoCurrencyRepository);
  });
}
