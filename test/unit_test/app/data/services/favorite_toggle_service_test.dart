import 'package:crypto_currency_tracker/src/app/data/services/favorite_toggle_service.dart';
import 'package:crypto_currency_tracker/src/app/domain/entities/crypto_currency.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late FavoriteToggleService service;

  setUp(() {
    service = FavoriteToggleService();
  });

  const id = "bitcoin";

  final List<CryptoCurrency> unfavoriteCryptoCurrency = [
    CryptoCurrency(
        "bitcoin", "Bitcoin", "BTC", "imageUrl", 45000, 1, 1500, 1.5),
  ];

  final List<CryptoCurrency> favoriteCryptoCurrency = [
    CryptoCurrency(
        "bitcoin", "Bitcoin", "BTC", "imageUrl", 45000, 1, 1500, 1.5, true),
  ];

  group("setFavorite", () {
    test("should toggle favorite property to true", () {
      var result = service.setFavorite(id, unfavoriteCryptoCurrency);

      expect(result, favoriteCryptoCurrency);
    });
  });

  group("unsetFavorite", () {
    test("should toggle favorite property to false", () {
      var result = service.setFavorite(id, favoriteCryptoCurrency);

      expect(result, unfavoriteCryptoCurrency);
    });
  });
}
