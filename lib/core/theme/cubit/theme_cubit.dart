import 'package:equatable/equatable.dart';
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
    final isDark = _hive.get<bool>(HiveConstants.isDarkModeKey) ?? false;
    emit(ThemeState(isDarkMode: isDark));
  }

  Future<void> toggleTheme() async {
    final newValue = !state.isDarkMode;
    await _hive.put(HiveConstants.isDarkModeKey, newValue);
    emit(state.copyWith(isDarkMode: newValue));
  }
}
