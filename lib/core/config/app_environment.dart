import 'package:flutter/services.dart';

abstract final class AppEnvironment {
  static String _mapboxAccessToken = const String.fromEnvironment(
    'MAPBOX_ACCESS_TOKEN',
  );

  static String get mapboxAccessToken => _mapboxAccessToken;

  static Future<void> load() async {
    if (_mapboxAccessToken.isNotEmpty) return;

    try {
      final contents = await rootBundle.loadString('.env');
      _mapboxAccessToken = _readValue(contents, 'MAPBOX_ACCESS_TOKEN');
    } on Object {
      // Keep the token empty so the UI can show its existing map fallback.
    }
  }

  static String _readValue(String contents, String key) {
    for (final rawLine in contents.split(RegExp(r'\r?\n'))) {
      final line = rawLine.trim();
      if (line.isEmpty || line.startsWith('#')) continue;

      final separator = line.indexOf('=');
      if (separator < 1 || line.substring(0, separator).trim() != key) {
        continue;
      }

      final value = line.substring(separator + 1).trim();
      if (value.length >= 2 &&
          ((value.startsWith('"') && value.endsWith('"')) ||
              (value.startsWith("'") && value.endsWith("'")))) {
        return value.substring(1, value.length - 1);
      }
      return value;
    }

    return '';
  }
}
