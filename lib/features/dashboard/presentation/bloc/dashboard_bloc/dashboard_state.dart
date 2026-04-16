part of 'dashboard_bloc.dart';

@immutable
class DashboardState extends Equatable {
  final DataStatus status;
  final DashboardDataEntity? data;
  final String? error;
  final String selectedTitle;
  final String selectedSubtitle;

  const DashboardState({
    this.status = DataStatus.initial,
    this.data,
    this.error,
    this.selectedTitle = AppDisplayConstants.appTitle,
    this.selectedSubtitle = AppDisplayConstants.unitLabel,
  });

  DashboardState copyWith({
    DataStatus? status,
    DashboardDataEntity? data,
    String? error,
    String? selectedTitle,
    String? selectedSubtitle,
  }) {
    return DashboardState(
      status: status ?? this.status,
      data: data ?? this.data,
      error: error ?? this.error,
      selectedTitle: selectedTitle ?? this.selectedTitle,
      selectedSubtitle: selectedSubtitle ?? this.selectedSubtitle,
    );
  }

  @override
  List<Object?> get props => [status, data, error, selectedTitle, selectedSubtitle];
}
