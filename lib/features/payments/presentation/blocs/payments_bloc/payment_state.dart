part of 'payment_bloc.dart';

@immutable
class PaymentState extends Equatable {
  final DataStatus status;
  final PaymentsDataEntity? data;
  final PaymentStatus? activeFilter;
  final String? error;

  const PaymentState({this.status = DataStatus.initial, this.data, this.activeFilter, this.error});

  PaymentState copyWith({DataStatus? status, PaymentsDataEntity? data, PaymentStatus? activeFilter, bool clearFilter = false, String? error}) {
    return PaymentState(
      status: status ?? this.status,
      data: data ?? this.data,
      activeFilter: clearFilter ? null : (activeFilter ?? this.activeFilter),
      error: error ?? this.error,
    );
  }

  List<PaymentItemEntity> get filteredItems {
    if (data == null) return [];
    final items = data!.items ?? const <PaymentItemEntity>[];
    if (activeFilter == null) return items;
    return items.where((i) => i.status == activeFilter).toList();
  }

  @override
  List<Object?> get props => [status, data, activeFilter, error];
}
