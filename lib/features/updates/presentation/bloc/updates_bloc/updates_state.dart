part of 'updates_bloc.dart';

@immutable
class UpdatesState extends Equatable {
  final DataStatus status;
  final ProjectProgress? data;
  final String? error;

  const UpdatesState({
    this.status = DataStatus.initial,
    this.data,
    this.error,
  });

  UpdatesState copyWith({
    DataStatus? status,
    ProjectProgress? data,
    String? error,
  }) {
    return UpdatesState(
      status: status ?? this.status,
      data: data ?? this.data,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, data, error];
}
