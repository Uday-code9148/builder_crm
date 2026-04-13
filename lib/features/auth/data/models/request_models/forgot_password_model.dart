import 'package:equatable/equatable.dart';

class ForgotPasswordModel extends Equatable {
  final String email;

  const ForgotPasswordModel({required this.email});

  @override
  List<Object> get props => [email];
}
