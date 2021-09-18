import 'package:crypto_currency_tracker/src/app/presentation/bloc/crypto_currency_bloc.dart';
import 'package:crypto_currency_tracker/src/app/presentation/widgets/favorite_crypto_currency_list.dart';
import 'package:crypto_currency_tracker/src/app/presentation/widgets/top_crypto_currency_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';

class CryptoCurrencyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CryptoCurrencyBloc>(context).stream.listen(print);

    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Crypto Currency Tracker"),
            bottom: TabBar(
              onTap: (tabIndex) {
                if (tabIndex == 0) {
                  BlocProvider.of<CryptoCurrencyBloc>(context)
                      .add(GetTopCryptoCurrenciesEvent());
                } else {
                  BlocProvider.of<CryptoCurrencyBloc>(context)
                      .add(GetFavoriteCryptoCurrenciesEvent());
                }
              },
              tabs: [
                Tab(text: "Top"),
                Tab(text: "Favorite"),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              TopCryptoCurrencyList(),
              FavoriteCryptoCurrencyList(),
            ],
          ),
        ));
  }
}
