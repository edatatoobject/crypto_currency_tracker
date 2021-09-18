import 'package:crypto_currency_tracker/src/app/data/datasources/crypto_currency_local_data_source.dart';
import 'package:crypto_currency_tracker/src/app/data/datasources/crypto_currency_remote_data_source.dart';
import 'package:crypto_currency_tracker/src/app/data/repositories/crypto_currency_repository_impl.dart';
import 'package:crypto_currency_tracker/src/app/data/services/favorite_toggle_service.dart';
import 'package:crypto_currency_tracker/src/app/domain/repositories/cyrpto_currency_repository.dart';
import 'package:crypto_currency_tracker/src/app/domain/usecases/add_favorite_crypto_currency.dart';
import 'package:crypto_currency_tracker/src/app/domain/usecases/get_favorite_crypto_currencies.dart';
import 'package:crypto_currency_tracker/src/app/domain/usecases/get_top_crypto_currencies.dart';
import 'package:crypto_currency_tracker/src/app/domain/usecases/remove_favorite_crypto_currency.dart';
import 'package:crypto_currency_tracker/src/app/presentation/bloc/crypto_currency_bloc.dart';
import 'package:crypto_currency_tracker/src/core/network/network_info.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //block
  sl.registerFactory(
    () => CryptoCurrencyBloc(
        addFavorite: sl(),
        removeFavorite: sl(),
        getTopCryptoCurrencies: sl(),
        getFavoriteCryptoCurrency: sl()),
  );
  //usecases
  sl.registerLazySingleton(() => AddFavoriteCryptoCurrency(sl()));
  sl.registerLazySingleton(() => RemoveFavoriteCryptoCurrency(sl()));
  sl.registerLazySingleton(() => GetTopCryptoCurrencies(sl()));
  sl.registerLazySingleton(() => GetFavoriteCryptoCurrency(sl()));

  //repository
  sl.registerLazySingleton<CryptoCurrencyRepository>(
      () => CryptoCurrencyRepositoryImpl(sl(), sl(), sl(), sl()));

  //data sources
  sl.registerLazySingleton<CryptoCurrencyLocalDataSource>(
      () => CryptoCurrencyLocalDataSourceImpl(sl()));
  sl.registerLazySingleton<CryptoCurrencyRemoteDataSource>(
      () => CryptoCurrencyRemoteDataSourceImpl(sl()));

  //! Features - Number Trivia

  //! Core
  sl.registerLazySingleton(() => FavoriteToggleService());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
