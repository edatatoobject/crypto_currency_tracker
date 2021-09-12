import 'package:crypto_currency_tracker/src/app/domain/repositories/cyrpto_currency_repository.dart';
import 'package:crypto_currency_tracker/src/app/domain/usecases/params/id_params.dart';
import 'package:crypto_currency_tracker/src/app/domain/usecases/remove_favorite_crypto_currency.dart';
import 'package:crypto_currency_tracker/src/core/usecases/usecase.dart';
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

  test("should remove crypto currency from favorites", () async {
    when(() => mockCryptoCurrencyRepository.removeFavoriteCryptoCurrency(id))
        .thenAnswer((_) async => Right(NoReturn()));

    var result = await usecase(const IdParams(id: id));

    expect(result, Right(NoReturn()));

    verify(() => mockCryptoCurrencyRepository.removeFavoriteCryptoCurrency(id));
    verifyNoMoreInteractions(mockCryptoCurrencyRepository);
  });
}
