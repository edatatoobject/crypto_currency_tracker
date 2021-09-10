import 'package:crypto_currency_tracker/src/app/domain/entities/crypto_currency.dart';
import 'package:crypto_currency_tracker/src/app/domain/repositories/cyrpto_currency_repository.dart';
import 'package:crypto_currency_tracker/src/app/domain/usecases/get_top_crypto_currencies.dart';
import 'package:crypto_currency_tracker/src/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCryptoCurrencyRepository extends Mock implements CryptoCurrencyRepository {}

void main() {
  late GetTopCryptoCurrencies usecase;
  late MockCryptoCurrencyRepository mockCryptoCurrencyRepository;

  setUp(() {
    mockCryptoCurrencyRepository = MockCryptoCurrencyRepository();
    usecase = GetTopCryptoCurrencies(mockCryptoCurrencyRepository);
  });

  const topCryptoCurrencies = [
    CryptoCurrency("bitcoin", "Bitcoin", "BTC", "imageUrl", 45000, 1, 1500, 1.5),
    CryptoCurrency("ethereum", "Ethereum", "ETH", "imageUrl", 3000, 2, 100, 1)
  ];

  test("get top ranked crypto coins", () async {
    when(() => mockCryptoCurrencyRepository.getTopCryptoCurrencies())
        .thenAnswer((_) async => const Right(topCryptoCurrencies));

    final result = await usecase(NoParams());

    expect(result, const Right(topCryptoCurrencies));
    verify(() => mockCryptoCurrencyRepository.getTopCryptoCurrencies());
    verifyNoMoreInteractions(mockCryptoCurrencyRepository);
  });
}
