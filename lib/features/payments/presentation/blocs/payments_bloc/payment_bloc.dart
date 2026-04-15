import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:temp_architecture_app_setup/core/enums/data_status.dart';
import 'package:temp_architecture_app_setup/core/enums/payment_status.dart';
import 'package:temp_architecture_app_setup/core/usecases/usecase.dart';
import 'package:temp_architecture_app_setup/features/payments/domain/entities/payment_entities.dart';
import 'package:temp_architecture_app_setup/features/payments/domain/usecases/get_payments_usecase.dart';

part 'payment_event.dart';
part 'payment_state.dart';

@injectable
class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final GetPaymentsUseCase _getPayments;

  PaymentBloc(this._getPayments) : super(const PaymentState()) {
    on<PaymentsLoadRequested>(_onLoad);
    on<PaymentsFilterChanged>(_onFilterChanged);
  }

  FutureOr<void> _onLoad(PaymentsLoadRequested event, Emitter<PaymentState> emit) async {
    emit(state.copyWith(status: DataStatus.loading));
    final result = await _getPayments(const NoParams());
    result.fold(
      (failure) => emit(state.copyWith(status: DataStatus.error, error: failure.message)),
      (data) => emit(state.copyWith(status: DataStatus.loaded, data: data)),
    );
  }

  FutureOr<void> _onFilterChanged(PaymentsFilterChanged event, Emitter<PaymentState> emit) {
    if (event.filter == null) {
      emit(state.copyWith(clearFilter: true));
    } else {
      emit(state.copyWith(activeFilter: event.filter));
    }
  }
}
