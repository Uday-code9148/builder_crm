part of 'dashboard_bloc.dart';

@immutable
class DashboardState extends Equatable {
  final DataStatus status;
  final DashboardData? data;
  final String? error;

  const DashboardState({this.status = DataStatus.initial, this.data, this.error});

  DashboardState copyWith({DataStatus? status, DashboardData? data, String? error}) {
    return DashboardState(status: status ?? this.status, data: data ?? this.data, error: error ?? this.error);
  }

  @override
  List<Object?> get props => [status, data, error];
}
