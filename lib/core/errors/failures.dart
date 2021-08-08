import 'package:equatable/equatable.dart';

// Use Failures na linguagem interna
abstract class Failure extends Equatable {}

class ServerFailure extends Failure {
  @override
  List<Object?> get props => [];
}
