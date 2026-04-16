part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardEvent {}

class DashboardLoadRequested extends DashboardEvent {}

class DashboardPropertySelected extends DashboardEvent {
  final String title;
  final String subtitle;

  DashboardPropertySelected({required this.title, required this.subtitle});
}
