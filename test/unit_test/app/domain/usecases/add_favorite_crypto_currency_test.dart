import 'package:crypto_currency_tracker/src/app/domain/repositories/cyrpto_currency_repository.dart';
import 'package:crypto_currency_tracker/src/app/domain/usecases/add_favorite_crypto_currency.dart';
import 'package:crypto_currency_tracker/src/app/domain/usecases/params/id_params.dart';
import 'package:crypto_currency_tracker/src/core/usecases/usecase.dart';
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

  test("should add crypto currency to favorites", () async {
    when(() => mockCryptoCurrencyRepository.addFavoriteCryptoCurrency(id))
        .thenAnswer((_) async => Right(NoReturn()));

    var result = await usecase(const IdParams(id: id));

    expect(result, Right(NoReturn()));

    verify(() => mockCryptoCurrencyRepository.addFavoriteCryptoCurrency(id));
    verifyNoMoreInteractions(mockCryptoCurrencyRepository);
  });
}
