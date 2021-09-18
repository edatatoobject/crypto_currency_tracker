import 'package:crypto_currency_tracker/src/app/presentation/bloc/crypto_currency_bloc.dart';
import 'package:crypto_currency_tracker/src/app/presentation/pages/crypto_currency_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection_container.dart' as di;
import 'injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.purple,
        accentColor: Colors.purpleAccent,
      ),
      home: BlocProvider(
        create: (context) => sl<CryptoCurrencyBloc>(),
        child: CryptoCurrencyPage(),
      ),
    );
  }
}
