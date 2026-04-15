part of 'payment_bloc.dart';

@immutable
sealed class PaymentEvent {
  const PaymentEvent();
}

class PaymentsLoadRequested extends PaymentEvent {
  const PaymentsLoadRequested();
}

class PaymentsFilterChanged extends PaymentEvent {
  final PaymentStatus? filter; // null = All
  const PaymentsFilterChanged(this.filter) : super();
}
