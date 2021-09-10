import 'dart:convert';

import 'package:crypto_currency_tracker/src/app/data/models/crypto_coin_model.dart';
import 'package:crypto_currency_tracker/src/app/domain/entities/crypto_currency.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  const CryptoCurrencyModel cryptoCurrencyModel = CryptoCurrencyModel(
      "bitcoin", "Bitcoin", "BTC", "imageUrl", 45000, 1, 1500, 1);
  test(
    'should be a subclass of CryptoCoin entity',
    () async {
      expect(cryptoCurrencyModel, isA<CryptoCurrency>());
    },
  );
  group("from json", () {
    test("should return a valid model when the JSON number is an integer",
        () async {
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('crypto_coin.json'));

      final result = CryptoCurrencyModel.fromJson(jsonMap);
      expect(result, cryptoCurrencyModel);
    });

    test("should return a valid model when the JSON number is an double",
        () async {
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('crypto_coin_double.json'));

      final result = CryptoCurrencyModel.fromJson(jsonMap);
      expect(result, cryptoCurrencyModel);
    });
  });

  group("to json", () {
    test("should return a JSON map containing the proper data", () {
      final result = cryptoCurrencyModel.toJson();

      const expectedJsonMap = {
        "id": "bitcoin",
        "name": "Bitcoin",
        "symbol": "btc",
        "image": "imageUrl",
        "current_price": 45000.0,
        "market_cap_rank": 1,
        "price_change_24h": 1500.0,
        "price_change_percentage_24h": 1.0
      };

      expect(result, expectedJsonMap);
    });
  });
}
