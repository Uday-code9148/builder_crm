/// Standard API response envelope.
///
/// Expects JSON in the shape:
/// ```json
/// { "succeeded": true, "message": "OK", "errors": [], "data": { ... } }
/// ```
class ResponseWrapper<T> {
  final bool succeeded;
  final String? message;
  final List<String>? errors;
  final T? data;

  const ResponseWrapper({required this.succeeded, this.message, this.errors, this.data});

  factory ResponseWrapper.fromJson(Map<String, dynamic> json, T Function(dynamic json) fromJsonT) {
    final dynamic raw = json['data'];
    final T? parsed;

    if (raw == null || raw is String || raw is bool || raw is num) {
      parsed = raw as T?;
    } else {
      parsed = fromJsonT(raw);
    }

    return ResponseWrapper(succeeded: json['succeeded'] as bool? ?? false, message: json['message'] as String?, errors: json['errors'] != null ? List<String>.from(json['errors'] as List) : null, data: parsed);
  }
}

// ─── Helper functions ─────────────────────────────────────────────────────────

/// Parses a single JSON object.
T fromJsonObject<T>(dynamic json, T Function(Map<String, dynamic>) fromJsonT) {
  if (json is Map<String, dynamic>) return fromJsonT(json);
  if (json is T) return json;
  throw ArgumentError('Expected Map<String, dynamic> or $T, got ${json.runtimeType}');
}

/// Parses a JSON array into a typed list.
List<T> fromJsonList<T>(dynamic json, T Function(Map<String, dynamic>) fromJsonT) {
  return (json as List<dynamic>).map((item) => fromJsonObject(item, fromJsonT)).toList();
}
