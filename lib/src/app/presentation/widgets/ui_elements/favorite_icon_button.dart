import 'package:crypto_currency_tracker/src/app/presentation/bloc/crypto_currency_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteIconButton extends StatefulWidget {
  final bool isFavotire;
  final String id;
  FavoriteIconButton(
    this.id,
    this.isFavotire, {
    Key? key,
  }) : super(key: key);

  @override
  _FavoriteIconButtonState createState() => _FavoriteIconButtonState();
}

class _FavoriteIconButtonState extends State<FavoriteIconButton> {
  @override
  void initState() {
    super.initState();
    isStateFavorite = widget.isFavotire;
  }

  late bool isStateFavorite;

  void _changeFavorite() {
    if (isStateFavorite) {
      BlocProvider.of<CryptoCurrencyBloc>(context)
          .add(RemoveFavoriteCryptoCurrencyEvent(widget.id));
    } else {
      BlocProvider.of<CryptoCurrencyBloc>(context)
          .add(AddFavoriteCryptoCurrencyEvent(widget.id));
    }

    setState(() {
      isStateFavorite = !isStateFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: _changeFavorite,
        icon: isStateFavorite
            ? Icon(
                Icons.favorite,
                color: Colors.red,
              )
            : Icon(Icons.favorite_border));
  }
}
