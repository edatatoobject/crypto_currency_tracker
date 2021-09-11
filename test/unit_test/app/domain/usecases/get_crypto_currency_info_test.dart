import 'package:crypto_currency_tracker/src/app/domain/entities/crypto_currency.dart';
import 'package:crypto_currency_tracker/src/app/domain/repositories/cyrpto_currency_repository.dart';
import 'package:crypto_currency_tracker/src/app/domain/usecases/get_crypto_currency_info.dart';
import 'package:crypto_currency_tracker/src/app/domain/usecases/params/id_params.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCryptoCurrencyRepository extends Mock implements CryptoCurrencyRepository {}

void main() {
  late GetCryptoCurrencyInfo usecase;
  late MockCryptoCurrencyRepository mockCryptoCurrencyRepository;

  setUp(() {
    mockCryptoCurrencyRepository = MockCryptoCurrencyRepository();
    usecase = GetCryptoCurrencyInfo(mockCryptoCurrencyRepository);
  });

  const id = "bitcoin";
  const cryptoCurrency =
      CryptoCurrency("bitcoin", "Bitcoin", "BTC", "imageUrl", 45000, 1, 1500, 1.5);

  test("should get crypto coin info from repository", () async {
    
    when(() => mockCryptoCurrencyRepository.getCryptoCurrencyInfo(id))
        .thenAnswer((_) async => const Right(cryptoCurrency));

    final result = await usecase(const IdParams(id: id));

    expect(result, const Right(cryptoCurrency));

    verify(() => mockCryptoCurrencyRepository.getCryptoCurrencyInfo(id));

    verifyNoMoreInteractions(mockCryptoCurrencyRepository);
  });
}
