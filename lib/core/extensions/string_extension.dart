import 'package:temp_architecture_app_setup/core/utils/validator_utils.dart';

import 'double_extension.dart';

extension StringExtension on String {
  bool isValidPhoneNumber() => ValidationUtils.isValidPhoneNumber(this);

  bool isValidEmail() => ValidationUtils.isValidEmail(this);

  /// Masks the local part of an email — e.g. `j***n@example.com`.
  String maskEmail() {
    if (!contains('@')) return this;
    final parts = split('@');
    final local = parts[0];
    final domain = parts[1];
    if (local.length <= 2) return this;
    final masked = '${local[0]}${'*' * (local.length - 2)}${local[local.length - 1]}';
    return '$masked@$domain';
  }

  /// Masks a phone number, leaving the last 2 digits visible.
  String maskPhone() {
    if (startsWith('+')) {
      final code = substring(0, 3);
      final number = substring(3);
      if (number.length > 4) {
        return '$code${'*' * (number.length - 2)}${number.substring(number.length - 2)}';
      }
      return this;
    }
    if (length > 4) {
      return '${substring(0, 2)}${'*' * (length - 4)}${substring(length - 2)}';
    }
    return this;
  }

  /// Converts `"john doe"` → `"J D"`.
  String nameToInitials() {
    try {
      final words = trim().split(' ').where((w) => w.isNotEmpty).toList();
      if (words.isEmpty) return 'N/A';
      if (words.length == 1) return words[0][0].toUpperCase();
      return '${words.first[0]}${words.last[0]}'.toUpperCase();
    } catch (_) {
      return 'N/A';
    }
  }

  /// Returns the string in Title Case.
  String toTitleCase() => split(' ').map((w) => w.isEmpty ? w : '${w[0].toUpperCase()}${w.substring(1).toLowerCase()}').join(' ');

  /// Converts a hex color string (e.g. `#RRGGBB`) to `0xFFRRGGBB` format.
  String toHexColorCode() => '0xFF${replaceAll('#', '')}';
}

extension NullableStringExtension on String? {
  bool isNullOrEmpty() => this?.isEmpty ?? true;

  bool isNotNullOrEmpty() => !(this?.isEmpty ?? true);

  /// Returns initials from a nullable name string.
  String nameToInitials() => (this ?? '').nameToInitials();

  /// Masks all but the last 4 characters with `X`.
  String get maskExceptLast4 {
    final v = this;
    if (v == null || v.isEmpty) return '';
    if (v.length <= 4) return 'X' * v.length;
    return '${'X' * (v.length - 4)}${v.substring(v.length - 4)}';
  }

  /// Masks the email with `X`, keeping first char, last char, and domain TLD.
  String get maskedEmail {
    final v = this;
    if (v == null || v.isEmpty) return '';
    try {
      final atIdx = v.indexOf('@');
      if (atIdx == -1) return v;
      final local = v.substring(0, atIdx);
      final domain = v.substring(atIdx + 1);
      final maskedLocal = local.length <= 2 ? '${local[0]}X' : '${local[0]}${'X' * (local.length - 2)}${local[local.length - 1]}';
      final domainParts = domain.split('.').where((e) => e.isNotEmpty).toList();
      if (domainParts.isEmpty) return '$maskedLocal@****';
      final maskedDomain =
          '${domainParts[0][0]}${'X' * (domainParts[0].length - 1)}'
          '${domainParts.length > 1 ? '.${domainParts.last}' : ''}';
      return '$maskedLocal@$maskedDomain';
    } catch (_) {
      return '';
    }
  }

  /// Formats a budget number (stored as a string) into human-readable words.
  String budgetToWord([String? currency]) {
    if (this == null) return '';
    final value = double.tryParse(this!);
    if (value == null) return '';
    return value.budgetToWord(currency);
  }
}
