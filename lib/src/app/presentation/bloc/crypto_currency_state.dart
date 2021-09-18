part of 'crypto_currency_bloc.dart';

abstract class CryptoCurrencyState extends Equatable {
  final List properties;
  const CryptoCurrencyState([this.properties = const <dynamic>[]]);

  @override
  List<Object> get props => [...properties];
}

class EmptyState extends CryptoCurrencyState {}

class LoadingState extends CryptoCurrencyState {}

class LoadedState extends CryptoCurrencyState {
  final List<CryptoCurrency> cryptoCurrency;

  LoadedState(this.cryptoCurrency) : super([cryptoCurrency]);
}

class FavoriteLoadedState extends CryptoCurrencyState {
  final List<CryptoCurrency> cryptoCurrency;

  FavoriteLoadedState(this.cryptoCurrency) : super([cryptoCurrency]);
}

class ErrorState extends CryptoCurrencyState {
  final String message;
  final CryptoCurrencyState previusState;

  ErrorState(this.message, this.previusState) : super([message, previusState]);
}
