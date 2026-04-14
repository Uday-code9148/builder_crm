import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:temp_architecture_app_setup/core/constants/hive_constants.dart';
import 'package:temp_architecture_app_setup/core/services/storage_service/hive_service.dart';

part 'theme_state.dart';

@singleton
class ThemeCubit extends Cubit<ThemeState> {
  final HiveService _hive;

  ThemeCubit(this._hive) : super(const ThemeState()) {
    _loadTheme();
  }

  void _loadTheme() {
    final index = _hive.get<int>(HiveConstants.themeModeKey);
    final mode = index != null ? ThemeMode.values[index] : ThemeMode.system;
    emit(ThemeState(themeMode: mode));
  }

  Future<void> setTheme(ThemeMode mode) async {
    await _hive.put(HiveConstants.themeModeKey, mode.index);
    emit(state.copyWith(themeMode: mode));
  }
}
