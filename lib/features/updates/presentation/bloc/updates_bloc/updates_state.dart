part of 'updates_bloc.dart';

@immutable
class UpdatesState extends Equatable {
  final DataStatus status;
  final UpdatesViewModel? viewModel;
  final String? error;

  const UpdatesState({this.status = DataStatus.initial, this.viewModel, this.error});

  UpdatesState copyWith({DataStatus? status, UpdatesViewModel? viewModel, String? error}) {
    return UpdatesState(
      status: status ?? this.status,
      viewModel: viewModel ?? this.viewModel,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, viewModel, error];
}
