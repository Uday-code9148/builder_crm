import 'package:equatable/equatable.dart';

class ConfirmForgotPasswordModel extends Equatable {
  final String email;
  final String newPassword;
  final String confirmationCode;

  const ConfirmForgotPasswordModel({
    required this.email,
    required this.newPassword,
    required this.confirmationCode,
  });

  @override
  List<Object> get props => [email, newPassword, confirmationCode];
}
