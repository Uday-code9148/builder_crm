part of 'dashboard_bloc.dart';

@immutable
class DashboardState extends Equatable {
  final DataStatus status;
  final DashboardViewModel? viewModel;
  final String? error;
  final String selectedTitle;
  final String selectedSubtitle;

  const DashboardState({
    this.status = DataStatus.initial,
    this.viewModel,
    this.error,
    this.selectedTitle = AppDisplayConstants.appTitle,
    this.selectedSubtitle = AppDisplayConstants.unitLabel,
  });

  DashboardState copyWith({
    DataStatus? status,
    DashboardViewModel? viewModel,
    String? error,
    String? selectedTitle,
    String? selectedSubtitle,
  }) {
    return DashboardState(
      status: status ?? this.status,
      viewModel: viewModel ?? this.viewModel,
      error: error ?? this.error,
      selectedTitle: selectedTitle ?? this.selectedTitle,
      selectedSubtitle: selectedSubtitle ?? this.selectedSubtitle,
    );
  }

  @override
  List<Object?> get props => [status, viewModel, error, selectedTitle, selectedSubtitle];
}
