part of 'updates_bloc.dart';

@immutable
sealed class UpdatesEvent {
  const UpdatesEvent();
}

class UpdatesLoadRequested extends UpdatesEvent {
  const UpdatesLoadRequested();
}
