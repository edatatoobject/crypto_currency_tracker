import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final List properties;

  String get message => "";

  // If the subclasses have some properties, they'll get passed to this constructor
  // so that Equatable can perform value comparison.
  const Failure([this.properties = const <dynamic>[]]) : super();

  @override
  List<Object> get props => [properties];
}

// General failures
class ServerFailure extends Failure {
  @override
  String get message => "No access to the server";
}

class StorageFailure extends Failure {
  @override
  String get message => "No access to the storage ";
}
