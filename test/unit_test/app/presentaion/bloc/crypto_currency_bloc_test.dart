import 'package:crypto_currency_tracker/src/app/domain/entities/crypto_currency.dart';
import 'package:crypto_currency_tracker/src/app/domain/usecases/add_favorite_crypto_currency.dart';
import 'package:crypto_currency_tracker/src/app/domain/usecases/get_favorite_crypto_currencies.dart';
import 'package:crypto_currency_tracker/src/app/domain/usecases/get_top_crypto_currencies.dart';
import 'package:crypto_currency_tracker/src/app/domain/usecases/params/id_and_crypto_currencies_params.dart';
import 'package:crypto_currency_tracker/src/app/domain/usecases/remove_favorite_crypto_currency.dart';
import 'package:crypto_currency_tracker/src/app/presentation/bloc/crypto_currency_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAddFavoriteCryptoCurrency extends Mock
    implements AddFavoriteCryptoCurrency {}

class MockRemoveFavoriteCryptoCurrency extends Mock
    implements RemoveFavoriteCryptoCurrency {}


class MockGetTopCryptoCurrency extends Mock implements GetTopCryptoCurrencies {}

class MockGetFavoriteCryptoCurrency extends Mock
    implements GetFavoriteCryptoCurrency {}

void main() {
  late CryptoCurrencyBloc bloc;
  late MockAddFavoriteCryptoCurrency mockAddFavorite;
  late MockRemoveFavoriteCryptoCurrency mockRemoveFavorite;
  late MockGetTopCryptoCurrency mockGetTop;
  late MockGetFavoriteCryptoCurrency mockGetFavotire;

  setUp(() {
    registerFallbackValue<IdAndCryptoCurrenciesParams>(
        IdAndCryptoCurrenciesParams(id: any(), cryptoCurrencies: any()));
    mockAddFavorite = MockAddFavoriteCryptoCurrency();
    mockRemoveFavorite = MockRemoveFavoriteCryptoCurrency();
    mockGetTop = MockGetTopCryptoCurrency();
    mockGetFavotire = MockGetFavoriteCryptoCurrency();
    bloc = CryptoCurrencyBloc(
        addFavorite: mockAddFavorite,
        removeFavorite: mockRemoveFavorite,
        getTopCryptoCurrencies: mockGetTop,
        getFavoriteCryptoCurrency: mockGetFavotire);
  });

  const id = "bitcoin";

  const List<CryptoCurrency> cryptoCurrencies = [
    CryptoCurrency(
        "bitcoin", "Bitcoin", "BTC", "imageUrl", 45000, 1, 1500, 1.5),
  ];

  const List<CryptoCurrency> favoriteCryptoCurrencies = [
    CryptoCurrency(
        "bitcoin", "Bitcoin", "BTC", "imageUrl", 45000, 1, 1500, 1.5, true),
  ];

  test('initialState should be Empty', () {
    // assert
    expect(bloc.state, equals(EmptyState()));
  });

  group("addFavoriteCryptoCurrency", () {
    test("should add currency to favorite", () async {
      when(() => mockAddFavorite(any()))
          .thenAnswer((_) async => Right(favoriteCryptoCurrencies));

      bloc.add(AddFavoriteCryptoCurrencyEvent(id, cryptoCurrencies));

      await untilCalled(() => mockAddFavorite(any()));

      verify(() => mockAddFavorite(any()));
    });
  });
  group("removeFavoriteCryptoCurrency", () {
    test("should add currency to favorite", () async {
      when(() => mockAddFavorite(any()))
          .thenAnswer((_) async => Right(cryptoCurrencies));

      bloc.add(AddFavoriteCryptoCurrencyEvent(id, favoriteCryptoCurrencies));

      await untilCalled(() => mockAddFavorite(any()));

      verify(() => mockAddFavorite(any()));
    });
  });
}
