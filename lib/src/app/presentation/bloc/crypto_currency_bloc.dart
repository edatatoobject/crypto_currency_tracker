import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:crypto_currency_tracker/src/app/domain/entities/crypto_currency.dart';
import 'package:crypto_currency_tracker/src/app/domain/usecases/add_favorite_crypto_currency.dart';
import 'package:crypto_currency_tracker/src/app/domain/usecases/get_favorite_crypto_currencies.dart';
import 'package:crypto_currency_tracker/src/app/domain/usecases/get_top_crypto_currencies.dart';
import 'package:crypto_currency_tracker/src/app/domain/usecases/params/id_and_crypto_currencies_params.dart';
import 'package:crypto_currency_tracker/src/app/domain/usecases/remove_favorite_crypto_currency.dart';
import 'package:crypto_currency_tracker/src/core/error/failure.dart';
import 'package:crypto_currency_tracker/src/core/usecases/usecase.dart';
import 'package:equatable/equatable.dart';

part 'crypto_currency_event.dart';
part 'crypto_currency_state.dart';

class CryptoCurrencyBloc
    extends Bloc<CryptoCurrencyEvent, CryptoCurrencyState> {
  final AddFavoriteCryptoCurrency addFavorite;
  final RemoveFavoriteCryptoCurrency removeFavorite;
  final GetTopCryptoCurrencies getTopCryptoCurrencies;
  final GetFavoriteCryptoCurrency getFavoriteCryptoCurrency;

  CryptoCurrencyBloc(
      {required this.addFavorite,
      required this.removeFavorite,
      required this.getTopCryptoCurrencies,
      required this.getFavoriteCryptoCurrency})
      : super(LoadingState());

  @override
  Stream<CryptoCurrencyState> mapEventToState(
    CryptoCurrencyEvent event,
  ) async* {
    if (event is AddFavoriteCryptoCurrencyEvent) {
      yield* _addFavoriteEvent(event);
    } else if (event is RemoveFavoriteCryptoCurrencyEvent) {
      yield* _removeFavoriteEvent(event);
    } else if (event is GetTopCryptoCurrenciesEvent) {
      yield* _getTopEvent(event);
    } else if (event is GetFavoriteCryptoCurrenciesEvent) {
      yield* _getFavoriteEvent(event);
    }
  }

  Stream<CryptoCurrencyState> _addFavoriteEvent(
      AddFavoriteCryptoCurrencyEvent event) async* {
    var addFavoriteResult = await addFavorite(IdAndCryptoCurrenciesParams(
        id: event.id, cryptoCurrencies: event.cryptoCurrencies));

    yield* addFavoriteResult.fold((failure) => _onFailure(failure),
        (cryptoCurrencies) async* {
      yield LoadedState(cryptoCurrencies);
    });
  }

  Stream<CryptoCurrencyState> _removeFavoriteEvent(
      RemoveFavoriteCryptoCurrencyEvent event) async* {
    var removeFavoriteResult = await removeFavorite(IdAndCryptoCurrenciesParams(
        id: event.id, cryptoCurrencies: event.cryptoCurrencies));

    yield* removeFavoriteResult.fold((failure) => _onFailure(failure),
        (cryptoCurrencies) async* {
      yield LoadedState(cryptoCurrencies);
    });
  }

  Stream<CryptoCurrencyState> _getTopEvent(
      GetTopCryptoCurrenciesEvent event) async* {
    yield LoadingState();

    var getTopResult = await getTopCryptoCurrencies(NoParams());

    yield getTopResult.fold((failure) => state, (cryptoCurrencies) {
      return LoadedState(cryptoCurrencies);
    });
  }

  Stream<CryptoCurrencyState> _getFavoriteEvent(
      GetFavoriteCryptoCurrenciesEvent event) async* {
    yield LoadingState();
    var getFavoriteResult = await getFavoriteCryptoCurrency(NoParams());

    yield* getFavoriteResult.fold((failure) => _onFailure(failure),
        (cryptoCurrencies) async* {
      if (cryptoCurrencies.isEmpty) {
        yield EmptyFavoriteState();
      } else {
        yield FavoriteLoadedState(cryptoCurrencies);
      }
    });
  }

  Stream<CryptoCurrencyState> _onFailure(Failure failure) async* {
    print(failure.message);
    yield state;
  }
}
