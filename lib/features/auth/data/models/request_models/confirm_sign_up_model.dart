import 'package:equatable/equatable.dart';

class ConfirmSignUpModel extends Equatable {
  final String email;
  final String confirmationCode;

  const ConfirmSignUpModel({required this.email, required this.confirmationCode});

  @override
  List<Object> get props => [email, confirmationCode];
}
