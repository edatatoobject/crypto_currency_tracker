import 'package:crypto_currency_tracker/src/app/domain/entities/crypto_coin.dart';
import 'package:crypto_currency_tracker/src/app/domain/repositories/cyrpto_coin_repository.dart';
import 'package:crypto_currency_tracker/src/app/domain/usecases/get_top_crypto_coins.dart';
import 'package:crypto_currency_tracker/src/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCryptoCoinRepository extends Mock implements CryptoCoinRepository {}

void main() {
  late GetTopCryptoCoins usecase;
  late MockCryptoCoinRepository mockCryptoCoinRepository;

  setUp(() {
    mockCryptoCoinRepository = MockCryptoCoinRepository();
    usecase = GetTopCryptoCoins(mockCryptoCoinRepository);
  });

  const topCryptoCoins = [
    CryptoCoin("bitcoin", "Bitcoin", "BTC", "imageUrl", 45000, 1, 1500, 1.5),
    CryptoCoin("ethereum", "Ethereum", "ETH", "imageUrl", 3000, 2, 100, 1)
  ];

  test("get top ranked crypto coins", () async {
    when(() => mockCryptoCoinRepository.getTopCryptoCoins())
        .thenAnswer((_) async => const Right(topCryptoCoins));

    final result = await usecase(NoParams());

    expect(result, const Right(topCryptoCoins));
    verify(() => mockCryptoCoinRepository.getTopCryptoCoins());
    verifyNoMoreInteractions(mockCryptoCoinRepository);
  });
}
