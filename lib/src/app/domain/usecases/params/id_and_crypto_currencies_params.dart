import 'package:crypto_currency_tracker/src/app/domain/entities/crypto_currency.dart';
import 'package:equatable/equatable.dart';

class IdAndCryptoCurrenciesParams extends Equatable {
  final String id;
  final List<CryptoCurrency> cryptoCurrencies;

  const IdAndCryptoCurrenciesParams({required this.id, required this.cryptoCurrencies}) : super();

  @override
  List<Object?> get props => [id, cryptoCurrencies];
}
