import 'dart:convert';

import 'package:crypto_currency_tracker/src/app/data/datasources/crypto_currency_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late CryptoCurrencyLocalDataSourceImpl dataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = CryptoCurrencyLocalDataSourceImpl(mockSharedPreferences);
  });

  const favoriteProperty = CryptoCurrencyLocalDataSourceImpl.favoriteProperty;

  const firstFavoriteId = "bitcoin";
  const secondFavoriteId = "ethereum";
  const List<String> favoriteIds = ["bitcoin", "ethereum"];
  const List<String> favoriteSingleId = ["bitcoin"];

  group("getFavoriteCryptoCurrency", () {
    test("shoul return array of favorite crypto currency ids", () async {
      when(() => mockSharedPreferences.getStringList(favoriteProperty))
          .thenReturn((jsonDecode(fixture("crypto_currency_favorite.json"))
                  as List<dynamic>)
              .cast<String>());

      final result = await dataSource.getFavoriteCryptoCurrency();

      expect(result, favoriteIds);

      verify(() => dataSource.getFavoriteCryptoCurrency());
      verifyNoMoreInteractions(mockSharedPreferences);
    });

    test("should return empty list if cache empty", () async {
      when(() => mockSharedPreferences.getStringList(favoriteProperty))
          .thenReturn(null);

      final result = await dataSource.getFavoriteCryptoCurrency();

      expect(result, []);

      verify(() => dataSource.getFavoriteCryptoCurrency());
      verifyNoMoreInteractions(mockSharedPreferences);
    });
  });

  group("add and remove FavoriteCryptoCurrency", () {
    test("should add favorite crypto currency", () async {
      when(() => mockSharedPreferences.getStringList(favoriteProperty))
          .thenReturn(favoriteSingleId);

      when(() => mockSharedPreferences.setStringList(
              favoriteProperty, favoriteIds))
          .thenAnswer((_) async => true);

      await dataSource.addFavoriteCurrency(secondFavoriteId);

      verify(() => mockSharedPreferences.getStringList(favoriteProperty));
      verify(() => mockSharedPreferences.setStringList(
          favoriteProperty, favoriteIds));

      verifyNoMoreInteractions(mockSharedPreferences);
    });

    test("should remove favorite crypto currency", () async {
      when(() => mockSharedPreferences.getStringList(favoriteProperty))
          .thenReturn(favoriteSingleId);

      when(() => mockSharedPreferences.setStringList(
              favoriteProperty, []))
          .thenAnswer((_) async => true);

      await dataSource.removeFavoriteCurrency(firstFavoriteId);

      verify(() => mockSharedPreferences.getStringList(favoriteProperty));
      verify(
          () => mockSharedPreferences.setStringList(favoriteProperty, []));

      verifyNoMoreInteractions(mockSharedPreferences);
    });
  });
}
