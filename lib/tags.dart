/// The `Tag` class is used to categorize log messages.
/// This ensures logs are structured and easier to filter.
///
/// The class defines basic tags such as `auth`, `network`, `dataService`,
/// and allows developers to create their own custom tags by extending this class.
///
/// Example:
///
/// ```dart
/// AppLogger().debug('Authenticating user', tag: Tag.auth);
/// AppLogger().info('Fetching data', tag: Tag.dataService);
/// ```
///
/// Developers can also extend the `Tag` class to define custom tags:
///
/// ```dart
/// class CustomTag extends Tag {
///   static const Tag repository = CustomTag._('Repository');
///   static const Tag payment = CustomTag._('Payment');
///
///   const CustomTag._(String value) : super._(value);
/// }
///
/// AppLogger().info('Fetching data from repository', tag: CustomTag.repository);
/// ``
abstract class Tag {
  final String value;

  const Tag._(this.value);

  // Basic predefined tags
  /// Predefined tag for authentication-related logs.
  static const Tag auth = _BasicTag('Auth');

  /// Predefined tag for logs related to data services (e.g., backend services).
  static const Tag dataService = _BasicTag('DataService');

  /// Predefined tag for logs related to user interface actions.
  static const Tag ui = _BasicTag('UI');

  /// Predefined tag for logs related to network operations (e.g., API calls).
  static const Tag network = _BasicTag('Network');

  /// Predefined tag for database interactions.
  static const Tag database = _BasicTag('Database');

  /// Predefined tag for API operations and requests.
  static const Tag api = _BasicTag('API');

  /// Predefined tag for caching mechanisms.
  static const Tag cache = _BasicTag('Cache');

  /// Predefined tag for security and authentication concerns.
  static const Tag security = _BasicTag('Security');

  /// Predefined tag for performance-related logs.
  static const Tag performance = _BasicTag('Performance');

  /// Predefined tag for analytics and tracking logs.
  static const Tag analytics = _BasicTag('Analytics');

  @override
  String toString() => value;
}

// Internal class to represent default tags
class _BasicTag extends Tag {
  const _BasicTag(super.value) : super._();
}
