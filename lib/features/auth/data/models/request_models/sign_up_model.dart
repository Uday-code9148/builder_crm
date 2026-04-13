import 'package:equatable/equatable.dart';

class SignUpModel extends Equatable {
  final String email;
  final String password;
  final String? name;

  const SignUpModel({required this.email, required this.password, this.name});

  @override
  List<Object?> get props => [email, password, name];
}
