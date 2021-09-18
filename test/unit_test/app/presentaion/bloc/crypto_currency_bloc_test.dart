import 'package:crypto_currency_tracker/src/app/domain/entities/crypto_currency.dart';
import 'package:crypto_currency_tracker/src/app/domain/usecases/add_favorite_crypto_currency.dart';
import 'package:crypto_currency_tracker/src/app/domain/usecases/get_favorite_crypto_currencies.dart';
import 'package:crypto_currency_tracker/src/app/domain/usecases/get_top_crypto_currencies.dart';
import 'package:crypto_currency_tracker/src/app/domain/usecases/params/id_and_crypto_currencies_params.dart';
import 'package:crypto_currency_tracker/src/app/domain/usecases/remove_favorite_crypto_currency.dart';
import 'package:crypto_currency_tracker/src/app/presentation/bloc/crypto_currency_bloc.dart';
import 'package:crypto_currency_tracker/src/core/usecases/usecase.dart';
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
        IdAndCryptoCurrenciesParams(id: "", cryptoCurrencies: []));
    registerFallbackValue<List<CryptoCurrency>>([]);
    registerFallbackValue<NoParams>(NoParams());

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

  const topCryptoCurrencies = [
    CryptoCurrency(
        "bitcoin", "Bitcoin", "BTC", "imageUrl", 45000, 1, 1500, 1.5),
    CryptoCurrency("ethereum", "Ethereum", "ETH", "imageUrl", 3000, 2, 100, 1)
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
      when(() => mockRemoveFavorite(any()))
          .thenAnswer((_) async => Right(cryptoCurrencies));

      bloc.add(RemoveFavoriteCryptoCurrencyEvent(id, favoriteCryptoCurrencies));

      await untilCalled(() => mockRemoveFavorite(any()));

      verify(() => mockRemoveFavorite(any()));
    });
  });

  group("getTopCryptoCurrencies", () {
    test("should get top crypto currenices", () async {
      when(() => mockGetTop(any()))
          .thenAnswer((_) async => Right(topCryptoCurrencies));

      bloc.add(GetTopCryptoCurrenciesEvent());

      await untilCalled(() => mockGetTop(any()));

      verify(() => mockGetTop(any()));
    });
  });

  group("getFavoriteCryptoCurrencies", () {
    test("sould return favorite crypto currencies", () async {
      when(() => mockGetFavotire(any()))
          .thenAnswer((_) async => Right(favoriteCryptoCurrencies));

      bloc.add(GetFavoriteCryptoCurrenciesEvent());

      await untilCalled(() => mockGetFavotire(any()));

      verify(() => mockGetFavotire(any()));
    });
  });
}
