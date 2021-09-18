part of 'crypto_currency_bloc.dart';

abstract class CryptoCurrencyEvent extends Equatable {
  final List properties;
  const CryptoCurrencyEvent([this.properties = const <dynamic>[]]);

  @override
  List<Object> get props => [...properties];
}

class AddFavoriteCryptoCurrencyEvent extends CryptoCurrencyEvent {
  final String id;

  AddFavoriteCryptoCurrencyEvent(this.id) : super([id]);
}

class RemoveFavoriteCryptoCurrencyEvent extends CryptoCurrencyEvent {
  final String id;

  RemoveFavoriteCryptoCurrencyEvent(this.id) : super([id]);
}

class GetCryptoCurrencyInfoEvent extends CryptoCurrencyEvent {
  final String id;

  GetCryptoCurrencyInfoEvent(this.id) : super([id]);
}

class GetFavoriteCryptoCurrenciesEvent extends CryptoCurrencyEvent {}

class GetTopCryptoCurrenciesEvent extends CryptoCurrencyEvent {}
