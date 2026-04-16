part of 'support_bloc.dart';

@immutable
class SupportState extends Equatable {
  final DataStatus status;
  final SupportViewModel? viewModel;
  final TicketStatus? activeFilter;
  final String? error;

  const SupportState({this.status = DataStatus.initial, this.viewModel, this.activeFilter, this.error});

  SupportState copyWith({
    DataStatus? status,
    SupportViewModel? viewModel,
    TicketStatus? activeFilter,
    bool clearFilter = false,
    String? error,
  }) {
    return SupportState(
      status: status ?? this.status,
      viewModel: viewModel ?? this.viewModel,
      activeFilter: clearFilter ? null : (activeFilter ?? this.activeFilter),
      error: error ?? this.error,
    );
  }

  List<TicketVM> get filteredTickets {
    if (viewModel == null) return const [];
    if (activeFilter == null) return viewModel!.allTickets;
    return viewModel!.allTickets.where((t) => t.status == activeFilter).toList();
  }

  @override
  List<Object?> get props => [status, viewModel, activeFilter, error];
}
