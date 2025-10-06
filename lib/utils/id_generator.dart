import 'dart:math';

/// Utility class for generating press card IDs
class IdGenerator {
  static final Random _random = Random();

  /// Generates a random 4-digit ID starting with 0
  static String generateId() {
    return '0${(_random.nextInt(900) + 100).toString()}';
  }
}
