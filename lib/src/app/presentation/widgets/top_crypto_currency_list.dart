import 'package:crypto_currency_tracker/src/app/presentation/bloc/crypto_currency_bloc.dart';
import 'package:crypto_currency_tracker/src/app/presentation/widgets/crypto_currency_list_item.dart';
import 'package:crypto_currency_tracker/src/app/presentation/widgets/ui_elements/error_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopCryptoCurrencyList extends StatelessWidget {
  const TopCryptoCurrencyList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CryptoCurrencyBloc, CryptoCurrencyState>(
        builder: (context, state) {
      if (state is LoadingState) {
        return Center(child: CircularProgressIndicator());
      } else if (state is LoadedState) {
        return ListView.builder(
          itemCount: state.cryptoCurrency.length,
          itemBuilder: (context, index) =>
              CryptoCurrencyListItem(state.cryptoCurrency[index]),
        );
      } else {
        return ErrorPlaceholder();
      }
    });
  }
}
