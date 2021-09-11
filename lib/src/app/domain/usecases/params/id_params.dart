import 'package:equatable/equatable.dart';

class IdParams extends Equatable {
  final String id;

  const IdParams({required this.id}) : super();

  @override
  List<Object?> get props => [id];
}