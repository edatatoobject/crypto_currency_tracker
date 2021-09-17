import 'dart:convert';
import 'dart:io';

import 'package:crypto_currency_tracker/src/app/data/models/crypto_currency_model.dart';
import 'package:crypto_currency_tracker/src/core/error/exception.dart';
import 'package:http/http.dart';

abstract class CryptoCurrencyRemoteDataSource {
  Future<CryptoCurrencyModel> getCryptoCurrencyInfo(String id);

  Future<List<CryptoCurrencyModel>> getCryptoCurrencyArray(List<String> ids);

  Future<List<CryptoCurrencyModel>> getTopCryptoCurrencies();
}

class CryptoCurrencyRemoteDataSourceImpl
    implements CryptoCurrencyRemoteDataSource {
  static const baseUrl =
      "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd";

  final Client client;

  CryptoCurrencyRemoteDataSourceImpl(this.client);

  @override
  Future<List<CryptoCurrencyModel>> getCryptoCurrencyArray(List<String> ids) async {
    var responce = await client.get(cryptoCurrencyArrayInfoUrl(ids));

    if (responce.statusCode != HttpStatus.ok) {
      throw ServerException();
    }

    List json = jsonDecode(responce.body);

    return json.map((e) => CryptoCurrencyModel.fromJson(e)).toList();
  }

  @override
  Future<CryptoCurrencyModel> getCryptoCurrencyInfo(String id) async {
    var responce = await client.get(cryptoCurrencyInfoUrl(id));

    if (responce.statusCode != HttpStatus.ok || responce.body == "[]") {
      throw ServerException();
    }

    List json = jsonDecode(responce.body);

    return CryptoCurrencyModel.fromJson(json.first);
  }

  @override
  Future<List<CryptoCurrencyModel>> getTopCryptoCurrencies() async {
    var responce = await client.get(topCryptoCurrenciesUrl());

    if (responce.statusCode != HttpStatus.ok) {
      throw ServerException();
    }

    List json = jsonDecode(responce.body);

    return json.map((e) => CryptoCurrencyModel.fromJson(e)).toList();
  }

//TODO: take out to service
  Uri topCryptoCurrenciesUrl() {
    return Uri.parse("$baseUrl&per_page=20");
  }

  Uri cryptoCurrencyInfoUrl(String id) {
    return Uri.parse("$baseUrl&ids=$id");
  }

  Uri cryptoCurrencyArrayInfoUrl(List<String> ids) {
    return Uri.parse("$baseUrl&ids=${ids.join(",")}");
  }
}
