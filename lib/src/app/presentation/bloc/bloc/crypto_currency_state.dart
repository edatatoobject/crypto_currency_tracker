part of 'crypto_currency_bloc.dart';

abstract class CryptoCurrencyState extends Equatable {
  final List properties;
  const CryptoCurrencyState([this.properties = const <dynamic>[]]);

  @override
  List<Object> get props => [...properties];
}

class Empty extends CryptoCurrencyState {}

class Loading extends CryptoCurrencyState {}

class Loaded extends CryptoCurrencyState {
  final CryptoCurrency cryptoCurrency;

  Loaded(this.cryptoCurrency) : super([cryptoCurrency]);
}

class LoadedList extends CryptoCurrencyState {
  final List<CryptoCurrency> cryptoCurrencies;

  LoadedList(this.cryptoCurrencies) : super([cryptoCurrencies]);
}



class Error extends CryptoCurrencyState {
  final String message;

  Error(this.message) : super([message]);
}