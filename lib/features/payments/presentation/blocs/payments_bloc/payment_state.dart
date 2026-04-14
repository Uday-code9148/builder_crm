part of 'payment_bloc.dart';

enum DataStatus { initial, loading, loaded, error }

@immutable
class PaymentState extends Equatable {
  final DataStatus status;
  final PaymentsData? data;
  final PaymentStatus? activeFilter;
  final String? error;

  const PaymentState({
    this.status = DataStatus.initial,
    this.data,
    this.activeFilter,
    this.error,
  });

  PaymentState copyWith({
    DataStatus? status,
    PaymentsData? data,
    PaymentStatus? activeFilter,
    bool clearFilter = false,
    String? error,
  }) {
    return PaymentState(
      status: status ?? this.status,
      data: data ?? this.data,
      activeFilter: clearFilter ? null : (activeFilter ?? this.activeFilter),
      error: error ?? this.error,
    );
  }

  List<PaymentItem> get filteredItems {
    if (data == null) return [];
    if (activeFilter == null) return data!.items;
    return data!.items.where((i) => i.status == activeFilter).toList();
  }

  @override
  List<Object?> get props => [status, data, activeFilter, error];
}
