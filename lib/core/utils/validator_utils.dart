class ValidationUtils {
  static bool isValidPhoneNumber(String phone) {
    final regex = RegExp(r'^(\+?1[-\s.]?)?\(?\d{3}\)?[-\s.]?\d{3}[-\s.]?\d{4}$|^(\+?91[-\s.]?)?\d{10}$', caseSensitive: false);
    return regex.hasMatch(phone) && phone.length >= 10 && phone.length <= 15;
  }

  static bool isValidEmail(String email) {
    final regex = RegExp(r'^[\w\-.+]+@([\w-]+\.)+[\w-]{2,4}$');
    return regex.hasMatch(email);
  }

  /// Returns an error string if [value] is blank, otherwise `null`.
  static String? required(String? value, [String message = 'This field is required']) {
    if (value == null || value.trim().isEmpty) return message;
    return null;
  }

  /// Returns an error string if [value] is not a valid email, otherwise `null`.
  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) return 'Email is required';
    if (!isValidEmail(value.trim())) return 'Enter a valid email address';
    return null;
  }

  /// Returns an error string if [value] is not a valid phone number, otherwise `null`.
  static String? phone(String? value) {
    if (value == null || value.trim().isEmpty) return 'Phone number is required';
    if (!isValidPhoneNumber(value.trim())) return 'Enter a valid phone number';
    return null;
  }

  /// Returns an error string if [value] is shorter than [minLength].
  static String? minLength(String? value, int minLength, [String? fieldName]) {
    if (value == null || value.length < minLength) {
      return '${fieldName ?? 'This field'} must be at least $minLength characters';
    }
    return null;
  }

  /// Validates a landline number (6–18 digits).
  static String? landline(String? value) {
    if (value == null || value.trim().isEmpty) return null;
    final cleaned = value.trim().replaceAll(RegExp(r'[\s\-()+]'), '');
    if (cleaned.length < 6 || cleaned.length > 18) {
      return 'Enter a valid landline number';
    }
    if (!RegExp(r'^\d+$').hasMatch(cleaned)) {
      return 'Enter a valid landline number';
    }
    return null;
  }
}
