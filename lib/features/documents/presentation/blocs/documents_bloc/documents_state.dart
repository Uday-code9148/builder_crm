part of 'documents_bloc.dart';

@immutable
class DocumentsState extends Equatable {
  final DataStatus status;
  final DocumentsDataEntity? data;
  final String? error;

  const DocumentsState({this.status = DataStatus.initial, this.data, this.error});

  DocumentsState copyWith({DataStatus? status, DocumentsDataEntity? data, String? error}) {
    return DocumentsState(status: status ?? this.status, data: data ?? this.data, error: error ?? this.error);
  }

  @override
  List<Object?> get props => [status, data, error];
}
