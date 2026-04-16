part of 'documents_bloc.dart';

@immutable
class DocumentsState extends Equatable {
  final DataStatus status;
  final DocumentsViewModel? viewModel;
  final String? error;

  const DocumentsState({this.status = DataStatus.initial, this.viewModel, this.error});

  DocumentsState copyWith({DataStatus? status, DocumentsViewModel? viewModel, String? error}) {
    return DocumentsState(
      status: status ?? this.status,
      viewModel: viewModel ?? this.viewModel,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, viewModel, error];
}
