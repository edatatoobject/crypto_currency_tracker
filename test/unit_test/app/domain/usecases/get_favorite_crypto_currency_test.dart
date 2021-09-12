import 'package:crypto_currency_tracker/src/app/domain/entities/crypto_currency.dart';
import 'package:crypto_currency_tracker/src/app/domain/repositories/cyrpto_currency_repository.dart';
import 'package:crypto_currency_tracker/src/app/domain/usecases/get_favorite_crypto_currencies.dart';
import 'package:crypto_currency_tracker/src/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCryptoCurrencyRepository extends Mock
    implements CryptoCurrencyRepository {}

void main() {
  late GetFavoriteCryptoCurrency usecase;
  late MockCryptoCurrencyRepository mockCryptoCurrencyRepository;

  setUp(() {
    mockCryptoCurrencyRepository = MockCryptoCurrencyRepository();
    usecase = GetFavoriteCryptoCurrency(mockCryptoCurrencyRepository);
  });

  const favoriteCryptoCurrencies = [
    CryptoCurrency("bitcoin", "Bitcoin", "BTC", "imageUrl", 45000, 1, 1500, 1.5),
    CryptoCurrency("ethereum", "Ethereum", "ETH", "imageUrl", 3000, 2, 100, 1)
  ];

  test("should get crypto currencies from favorites", () async {
    when(() => mockCryptoCurrencyRepository.getFavoriteCryptoCurrencies())
        .thenAnswer((_) async => const Right(favoriteCryptoCurrencies));

    var result = await usecase(NoParams());

    expect(result, const Right(favoriteCryptoCurrencies));

    verify(() => mockCryptoCurrencyRepository.getFavoriteCryptoCurrencies());
    verifyNoMoreInteractions(mockCryptoCurrencyRepository);
  });
}
