part of 'payment_bloc.dart';

@immutable
class PaymentState extends Equatable {
  final DataStatus status;
  final PaymentsViewModel? viewModel;
  final PaymentStatus? activeFilter;
  final String? error;

  const PaymentState({this.status = DataStatus.initial, this.viewModel, this.activeFilter, this.error});

  PaymentState copyWith({
    DataStatus? status,
    PaymentsViewModel? viewModel,
    PaymentStatus? activeFilter,
    bool clearFilter = false,
    String? error,
  }) {
    return PaymentState(
      status: status ?? this.status,
      viewModel: viewModel ?? this.viewModel,
      activeFilter: clearFilter ? null : (activeFilter ?? this.activeFilter),
      error: error ?? this.error,
    );
  }

  List<PaymentItemVM> get filteredItems {
    if (viewModel == null) return const [];
    if (activeFilter == null) return viewModel!.allItems;
    return viewModel!.allItems.where((i) => i.status == activeFilter).toList();
  }

  @override
  List<Object?> get props => [status, viewModel, activeFilter, error];
}
