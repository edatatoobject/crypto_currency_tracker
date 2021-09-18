part of 'crypto_currency_bloc.dart';

abstract class CryptoCurrencyEvent extends Equatable {
  final List properties;
  const CryptoCurrencyEvent([this.properties = const <dynamic>[]]);

  @override
  List<Object> get props => [...properties];
}

class AddFavoriteCryptoCurrencyEvent extends CryptoCurrencyEvent {
  final String id;
  final List<CryptoCurrency> cryptoCurrencies;

  AddFavoriteCryptoCurrencyEvent(this.id, this.cryptoCurrencies) : super([id, cryptoCurrencies]);
}

class RemoveFavoriteCryptoCurrencyEvent extends CryptoCurrencyEvent {
  final String id;
  final List<CryptoCurrency> cryptoCurrencies;

  RemoveFavoriteCryptoCurrencyEvent(this.id, this.cryptoCurrencies) : super([id, cryptoCurrencies]);
}

class GetFavoriteCryptoCurrenciesEvent extends CryptoCurrencyEvent {}

class GetTopCryptoCurrenciesEvent extends CryptoCurrencyEvent {}
