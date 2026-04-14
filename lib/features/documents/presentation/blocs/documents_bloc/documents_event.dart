part of 'documents_bloc.dart';

@immutable
sealed class DocumentsEvent {
  const DocumentsEvent();
}

class DocumentsLoadRequested extends DocumentsEvent {
  const DocumentsLoadRequested();
}
