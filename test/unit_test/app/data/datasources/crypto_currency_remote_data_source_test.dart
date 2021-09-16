import 'package:crypto_currency_tracker/src/app/data/datasources/crypto_currency_remote_data_source.dart';
import 'package:crypto_currency_tracker/src/app/data/models/crypto_currency_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements Client {}

void main() {
  late CryptoCurrencyRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = CryptoCurrencyRemoteDataSourceImpl(mockHttpClient);
  });

  final url = CryptoCurrencyRemoteDataSourceImpl.url;

  const List<String> ids = ["bitcoin", "ethereum"];
  const id = "bitcoin";

  const List<CryptoCurrencyModel> cryptoCurrencyModels = [
    CryptoCurrencyModel(
        "bitcoin", "Bitcoin", "BTC", "imageUrl", 45000, 1, 1500, 1),
    CryptoCurrencyModel(
        "ethereum", "Ethereum", "ETH", "imageUrl", 3000, 2, 100, 1)
  ];

  group("getCryptoCurrencyArray", () {
    test("should return array of crypto currencies fetched from server",
        () async {
          var 
        });
  });
}
