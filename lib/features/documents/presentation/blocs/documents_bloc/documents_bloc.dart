import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:temp_architecture_app_setup/core/enums/data_status.dart';
import 'package:temp_architecture_app_setup/core/usecases/usecase.dart';
import 'package:temp_architecture_app_setup/features/documents/domain/entity/document.dart';
import 'package:temp_architecture_app_setup/features/documents/domain/usecases/get_documents_usecase.dart';

part 'documents_event.dart';
part 'documents_state.dart';

@injectable
class DocumentsBloc extends Bloc<DocumentsEvent, DocumentsState> {
  final GetDocumentsUseCase _getDocuments;

  DocumentsBloc(this._getDocuments) : super(const DocumentsState()) {
    on<DocumentsLoadRequested>(_onLoad);
  }

  FutureOr<void> _onLoad(DocumentsLoadRequested event, Emitter<DocumentsState> emit) async {
    emit(state.copyWith(status: DataStatus.loading));
    final result = await _getDocuments(const NoParams());
    result.fold(
      (failure) => emit(state.copyWith(status: DataStatus.error, error: failure.message)),
      (data) => emit(state.copyWith(status: DataStatus.loaded, data: data)),
    );
  }
}
