import 'package:equatable/equatable.dart';

class ResendSignUpCodeModel extends Equatable {
  final String email;

  const ResendSignUpCodeModel({required this.email});

  @override
  List<Object> get props => [email];
}
