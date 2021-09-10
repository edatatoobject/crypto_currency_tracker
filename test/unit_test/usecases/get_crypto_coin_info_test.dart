import 'package:crypto_currency_tracker/src/app/domain/entities/crypto_coin.dart';
import 'package:crypto_currency_tracker/src/app/domain/repositories/cyrpto_coin_repository.dart';
import 'package:crypto_currency_tracker/src/app/domain/usecases/get_crypto_coin_info.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCryptoCoinRepository extends Mock implements CryptoCoinRepository {}

void main() {
  late GetCryptoCoinInfo usecase;
  late MockCryptoCoinRepository mockCryptoCoinRepository;

  setUp(() {
    mockCryptoCoinRepository = MockCryptoCoinRepository();
    usecase = GetCryptoCoinInfo(mockCryptoCoinRepository);
  });

  const id = "bitcoin";
  const cryptoCoin =
      CryptoCoin("bitcoin", "Bitcoin", "BTC", "imageUrl", 45000, 1, 1500, 1.5);

  test("should get crypto coin info from repository", () async {
    
    when(() => mockCryptoCoinRepository.getCryptoCoinInfo(id))
        .thenAnswer((_) async => const Right(cryptoCoin));

    final result = await usecase(const Params(id: id));

    expect(result, const Right(cryptoCoin));

    verify(() => mockCryptoCoinRepository.getCryptoCoinInfo(id));

    verifyNoMoreInteractions(mockCryptoCoinRepository);
  });
}
