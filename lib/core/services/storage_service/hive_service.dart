import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:temp_architecture_app_setup/core/constants/hive_constants.dart';

@singleton
class HiveService {
  // Hive boxes are opened in main.dart before DI is configured.
  Box get _settingsBox => Hive.box(HiveConstants.settingsBox);

  // ─── Key-Value (settings box) ───────────────────────────────────────────────

  /// Returns the value for [key], or null if not found.
  T? get<T>(String key) => _settingsBox.get(key) as T?;

  /// Returns the value for [key], or [defaultValue] if not found.
  T getOrDefault<T>(String key, T defaultValue) => _settingsBox.get(key) as T? ?? defaultValue;

  /// Returns true if the [key] exists in the settings box.
  bool containsKey(String key) => _settingsBox.containsKey(key);

  /// Returns all keys in the settings box.
  Iterable<dynamic> getKeys() => _settingsBox.keys;

  /// Returns all values in the settings box.
  Iterable<T> getAllValues<T>() => _settingsBox.values.cast<T>();

  /// Stores a single [key]-[value] pair.
  Future<void> put(String key, dynamic value) => _settingsBox.put(key, value);

  /// Stores multiple key-value pairs at once.
  Future<void> putAll(Map<String, dynamic> entries) => _settingsBox.putAll(entries);

  /// Deletes the value for [key].
  Future<void> delete(String key) => _settingsBox.delete(key);

  /// Deletes values for all the given [keys].
  Future<void> deleteAll(Iterable<String> keys) => _settingsBox.deleteAll(keys);

  /// Clears all key-value pairs from the settings box.
  Future<void> clear() => _settingsBox.clear();

  // ─── Typed boxes ────────────────────────────────────────────────────────────

  /// Returns a typed box by [boxName]. The box must be opened in main.dart first.
  Box<T> getBox<T>(String boxName) => Hive.box<T>(boxName);

  /// Appends [item] to the typed box (auto-incremented integer key).
  Future<void> addItem<T>(String boxName, T item) => Hive.box<T>(boxName).add(item);

  /// Appends all [items] to the typed box.
  Future<void> addItems<T>(String boxName, List<T> items) => Hive.box<T>(boxName).addAll(items);

  /// Stores [item] at the given [key] inside the typed box.
  Future<void> putItem<T>(String boxName, dynamic key, T item) => Hive.box<T>(boxName).put(key, item);

  /// Returns all items stored in the typed box.
  List<T> getAllItems<T>(String boxName) => Hive.box<T>(boxName).values.toList();

  /// Returns the item at [key] from the typed box, or null if not found.
  T? getItem<T>(String boxName, dynamic key) => Hive.box<T>(boxName).get(key);

  /// Deletes the item at [key] from the typed box.
  Future<void> removeItem<T>(String boxName, dynamic key) => Hive.box<T>(boxName).delete(key);

  /// Deletes items at all [keys] from the typed box.
  Future<void> removeItems<T>(String boxName, Iterable<dynamic> keys) => Hive.box<T>(boxName).deleteAll(keys);

  /// Clears all items from the typed box.
  Future<void> clearBox(String boxName) => Hive.box(boxName).clear();
}
