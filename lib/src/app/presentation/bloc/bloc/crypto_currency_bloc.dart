import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:crypto_currency_tracker/src/app/domain/entities/crypto_currency.dart';
import 'package:crypto_currency_tracker/src/app/domain/usecases/add_favorite_crypto_currency.dart';
import 'package:crypto_currency_tracker/src/app/domain/usecases/get_crypto_currency_info.dart';
import 'package:crypto_currency_tracker/src/app/domain/usecases/get_favorite_crypto_currencies.dart';
import 'package:crypto_currency_tracker/src/app/domain/usecases/get_top_crypto_currencies.dart';
import 'package:crypto_currency_tracker/src/app/domain/usecases/params/id_params.dart';
import 'package:crypto_currency_tracker/src/app/domain/usecases/remove_favorite_crypto_currency.dart';
import 'package:crypto_currency_tracker/src/core/error/failure.dart';
import 'package:equatable/equatable.dart';

part 'crypto_currency_event.dart';
part 'crypto_currency_state.dart';

class CryptoCurrencyBloc
    extends Bloc<CryptoCurrencyEvent, CryptoCurrencyState> {
  final AddFavoriteCryptoCurrency addFavorite;
  final RemoveFavoriteCryptoCurrency removeFavorite;
  final GetCryptoCurrencyInfo getCryptoCurrencyInfo;
  final GetTopCryptoCurrencies getTopCryptoCurrencies;
  final GetFavoriteCryptoCurrency getFavoriteCryptoCurrency;

  CryptoCurrencyBloc(
      {required this.addFavorite,
      required this.removeFavorite,
      required this.getCryptoCurrencyInfo,
      required this.getTopCryptoCurrencies,
      required this.getFavoriteCryptoCurrency})
      : super(EmptyState());

  @override
  Stream<CryptoCurrencyState> mapEventToState(
    CryptoCurrencyEvent event,
  ) async* {
    var loadingProcessState = LoadingProcessState(state);
    yield loadingProcessState;
    if (event is AddFavoriteCryptoCurrencyEvent) {
      var result = await addFavorite(IdParams(id: event.id));

    result.fold(
          (failure) => Error(failure.message, loadingProcessState.previusState),
          (result) => loadingProcessState.previusState);
    }
  }

  Stream<CryptoCurrencyState> _eitherLoadedOrErrorState(
    Failure failure
  ) async* {
    
  }
}
