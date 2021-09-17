import 'package:crypto_currency_tracker/src/app/domain/usecases/add_favorite_crypto_currency.dart';
import 'package:crypto_currency_tracker/src/app/domain/usecases/get_crypto_currency_info.dart';
import 'package:crypto_currency_tracker/src/app/domain/usecases/get_favorite_crypto_currencies.dart';
import 'package:crypto_currency_tracker/src/app/domain/usecases/get_top_crypto_currencies.dart';
import 'package:crypto_currency_tracker/src/app/domain/usecases/remove_favorite_crypto_currency.dart';
import 'package:crypto_currency_tracker/src/app/presentation/bloc/bloc/crypto_currency_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAddFavoriteCryptoCurrency extends Mock
    implements AddFavoriteCryptoCurrency {}

class MockRemoveFavoriteCryptoCurrency extends Mock
    implements RemoveFavoriteCryptoCurrency {}

class MockGetCryptoCurrencyInfo extends Mock implements GetCryptoCurrencyInfo {}

class MockGetTopCryptoCurrency extends Mock implements GetTopCryptoCurrencies {}

class MockGetFavoriteCryptoCurrency extends Mock
    implements GetFavoriteCryptoCurrency {}

void main() {
  late CryptoCurrencyBloc bloc;
  late MockAddFavoriteCryptoCurrency mockAddFavorite;
  late MockRemoveFavoriteCryptoCurrency mockRemoveFavorite;
  late MockGetCryptoCurrencyInfo mockGetInfo;
  late MockGetTopCryptoCurrency mockGetTop;
  late MockGetFavoriteCryptoCurrency mockGetFavotire;

  setUp(() {
    mockAddFavorite = MockAddFavoriteCryptoCurrency();
    mockRemoveFavorite = MockRemoveFavoriteCryptoCurrency();
    mockGetInfo = MockGetCryptoCurrencyInfo();
    mockGetTop = MockGetTopCryptoCurrency();
    mockGetFavotire = MockGetFavoriteCryptoCurrency();
    bloc = CryptoCurrencyBloc(
        addFavorite: mockAddFavorite,
        removeFavorite: mockRemoveFavorite,
        getCryptoCurrencyInfo: mockGetInfo,
        getTopCryptoCurrencies: mockGetTop,
        getFavoriteCryptoCurrency: mockGetFavotire);
  });

  test('initialState should be Empty', () {
    // assert
    expect(bloc.state, equals(Empty()));
  });

  group("addFavoriteCryptoCurrency", () {
    
  });
}
