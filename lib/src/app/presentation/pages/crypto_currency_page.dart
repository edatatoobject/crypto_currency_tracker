import 'package:crypto_currency_tracker/src/app/presentation/bloc/crypto_currency_bloc.dart';
import 'package:crypto_currency_tracker/src/app/presentation/widgets/favorite_crypto_currency_list.dart';
import 'package:crypto_currency_tracker/src/app/presentation/widgets/top_crypto_currency_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CryptoCurrencyPage extends StatefulWidget {
  @override
  _CryptoCurrencyPageState createState() => _CryptoCurrencyPageState();
}

class _CryptoCurrencyPageState extends State<CryptoCurrencyPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);

    _tabController.addListener(_handleTabSelection);
    _handleTabSelection();
  }

  void _handleTabSelection() {
    if (_tabController.index == 0) {
      BlocProvider.of<CryptoCurrencyBloc>(context)
          .add(GetTopCryptoCurrenciesEvent());
    } else {
      BlocProvider.of<CryptoCurrencyBloc>(context)
          .add(GetFavoriteCryptoCurrenciesEvent());
    }

    print("tabbes");
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CryptoCurrencyBloc>(context).stream.listen(print);

    return Scaffold(
      appBar: AppBar(
        title: Text("Crypto Currency Tracker"),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: "Top"),
            Tab(text: "Favorite"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          TopCryptoCurrencyList(),
          FavoriteCryptoCurrencyList(),
        ],
      ),
    );
  }
}
