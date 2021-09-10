import 'dart:convert';

import 'package:crypto_currency_tracker/src/app/data/models/crypto_coin_model.dart';
import 'package:crypto_currency_tracker/src/app/domain/entities/crypto_coin.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  const CryptoCoinModel cryptoCoinModel = CryptoCoinModel(
      "bitcoin", "Bitcoin", "BTC", "imageUrl", 45000, 1, 1500, 1.5);
  test(
    'should be a subclass of CryptoCoin entity',
    () async {
      expect(cryptoCoinModel, isA<CryptoCoin>());
    },
  );

  test("from json", () async {
    final Map<String, dynamic> jsonMap =
        json.decode(fixture('crypto_coin.json'));

    final result = CryptoCoinModel.fromJson(jsonMap);
    expect(result, cryptoCoinModel);
  });
}
