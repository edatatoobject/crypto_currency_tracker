import 'package:crypto_currency_tracker/src/app/domain/entities/crypto_coin.dart';
import 'package:crypto_currency_tracker/src/app/domain/repositories/cyrpto_coin_repository.dart';
import 'package:crypto_currency_tracker/src/core/error/failure.dart';
import 'package:crypto_currency_tracker/src/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetCryptoCoinInfo extends UseCase<CryptoCoin, Params> {
  final CryptoCoinRepository repository;

  GetCryptoCoinInfo(this.repository);

  @override
  Future<Either<Failure, CryptoCoin>> call(Params params) async {
    return await repository.getCryptoCoinInfo(params.id);
  }
}

class Params extends Equatable {
  final String id;

  const Params({required this.id}) : super();

  @override
  List<Object?> get props => [id];
}
