import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime? {
  /// `"3 Jan, 2025 at 4:30 PM"`
  String toDateTimeString() {
    if (this == null) return '';
    return DateFormat("d MMM, yyyy 'at' h:mm a").format(this!);
  }

  /// `"3 Jan, 2025"`
  String toDateString() {
    if (this == null) return '';
    return DateFormat('d MMM, yyyy').format(this!);
  }

  /// Formats with a custom [format] string (intl pattern).
  String customFormat(String format) {
    if (this == null) return '';
    try {
      return DateFormat(format).format(this!);
    } catch (_) {
      return '';
    }
  }

  /// Returns `'Today'`, `'Yesterday'`, or `'3 Jan 2025'`.
  String toRelativeDateString() {
    if (this == null) return '';
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final target = DateTime(this!.year, this!.month, this!.day);

    if (target == today) return 'Today';
    if (target == yesterday) return 'Yesterday';
    return DateFormat.yMMMd().format(this!);
  }

  /// `"04:30 PM"`
  String toTimeString() {
    if (this == null) return '';
    return DateFormat('hh:mm a').format(this!);
  }

  /// `"04:30:15 PM"`
  String toFullTimeString() {
    if (this == null) return '';
    return DateFormat('hh:mm:ss a').format(this!);
  }

  /// Converts to UTC, keeping date components only (noon UTC).
  DateTime? toUniversalTime() {
    if (this == null) return null;
    return DateTime.utc(this!.year, this!.month, this!.day, 12);
  }

  /// Full UTC conversion preserving all time components.
  DateTime? toUtc() {
    if (this == null) return null;
    return DateTime.utc(this!.year, this!.month, this!.day, this!.hour, this!.minute, this!.second, this!.millisecond, this!.microsecond);
  }

  /// Returns `true` if the date has changed relative to [referenceDate] (defaults to now).
  bool hasDayChanged({DateTime? referenceDate}) {
    if (this == null) return true;
    final ref = referenceDate ?? DateTime.now();
    return ref.year != this!.year || ref.month != this!.month || ref.day != this!.day;
  }
}
