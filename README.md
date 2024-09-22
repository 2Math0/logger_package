# AppLogger with Tag System

This package provides a structured logging system that enforces the use of tags to categorize log messages. Tags help in filtering, searching, and organizing logs efficiently.

## Features

- **Tag-based Logging**: Every log entry can optionally have a tag, making it easier to categorize and filter logs.
- **Predefined Tags**: Common tags like `auth`, `network`, `dataService`, `ui`, `database`, etc., are provided by default.
- **Customizable Tags**: Developers can extend the `Tag` class to create custom tags specific to their projects.
- **File Logging**: Logs can be saved to a file, allowing users to download them for review.
- **Log Collection**: Collected logs can be accessed for display in the UI.

## Installation

Add the following to your `pubspec.yaml` file:

```yaml
dependencies:
  logger_package:
    git:
      url: https://2math0.github.io/logger_package/
      ref: main
```

Run `flutter pub get` to install the dependencies.

## Usage

### 1. **Predefined Tags**

The base `Tag` class provides several predefined tags that can be used for common logging categories.

```dart
AppLogger().debug('User authenticated successfully', tag: Tag.auth);
AppLogger().info('Data service fetching data', tag: Tag.dataService);
AppLogger().warning('Network connection slow', tag: Tag.network);
AppLogger().error('Failed to load data from database', tag: Tag.database);
```

### 2. **Custom Tags**

You can create your own tags by extending the `Tag` class.

```dart
class CustomTag extends Tag {
  static const Tag repository = CustomTag._('Repository');
  static const Tag payment = CustomTag._('Payment');
  
  const CustomTag._(String value) : super._(value);
}

AppLogger().info('Fetching data from repository', tag: CustomTag.repository);
AppLogger().error('Payment process failed', tag: CustomTag.payment);
```

### 3. **Configure Logging**

You can configure the logger to control whether logging is enabled and set the minimum log level:

```dart
AppLogger().configure(LoggerConfig(
  enableLogging: true,
  logLevel: Level.info,
  enableFileLogging: true,
  fileLogLevel: Level.warning,
  filePath: 'logs/app_logs.txt',
));
```

### 4. **Logging with Tags**

Here’s how to log messages with predefined and custom tags:

```dart
void main() {
  // Log a debug message with the 'Auth' tag
  AppLogger().debug('User is logging in', tag: Tag.auth);

  // Log an info message with a custom tag
  AppLogger().info('Repository data fetched', tag: CustomTag.repository);

  // Log a warning with the 'Network' tag
  AppLogger().warning('Network delay detected', tag: Tag.network);

  // Log an error with the 'Database' tag
  AppLogger().error('Database connection failed', tag: Tag.database);
}
```

### 5. **File Logging**

You can log messages to a file based on specified log levels. This allows users to download logs for review.

```dart
AppLogger().configure(LoggerConfig(
  enableFileLogging: true,
  fileLogLevels: [Level.warning], // Choose which log levels to include
  filePath: 'logs/app_logs.txt', // Specify the file path
));
```

### 6. **Retrieving Collected Logs**

You can retrieve all collected logs for displaying in the UI:

```dart
List<Object?> logs = AppLogger().getLogs();
```

### 7. **Only Print Warnings in Flutter Web Console**

If you want to restrict logging in Flutter Web to only show warnings or higher levels:

```dart
if (kIsWeb) {
  AppLogger().configure(LoggerConfig(
    enableLogging: true,
    logLevel: Level.warning,
  ));
}
```

## Predefined Tags

Here are the predefined tags available for use:

- **`Tag.auth`**: Logs related to authentication processes.
- **`Tag.dataService`**: Logs related to backend services or data operations.
- **`Tag.ui`**: Logs related to UI interactions and events.
- **`Tag.network`**: Logs related to network operations (e.g., API calls).
- **`Tag.database`**: Logs related to database queries and actions.
- **`Tag.api`**: Logs related to API requests and responses.
- **`Tag.cache`**: Logs related to cache mechanisms.
- **`Tag.security`**: Logs related to security processes.
- **`Tag.performance`**: Logs related to performance monitoring.
- **`Tag.analytics`**: Logs related to analytics tracking.

### Extending Tags

You can extend the `Tag` class to define custom tags for your project:

```dart
class CustomTag extends Tag {
  static const Tag repository = CustomTag._('Repository');
  static const Tag payment = CustomTag._('Payment');
  
  const CustomTag._(String value) : super._(value);
}
```

### Example with Custom Tags

```dart
AppLogger().info('Repository data fetched', tag: CustomTag.repository);
AppLogger().error('Payment process failed', tag: CustomTag.payment);
```

## License

This package is licensed under the Mozilla License.

---

### How the Tag System Works

The `Tag` system forces categorization of log messages by requiring a tag for every log. You can use predefined tags or create your own by extending the `Tag` class. This ensures logs are organized and can be filtered based on the log's tag, making it easier to track issues across different parts of an application.

### How to Log to a File

The logger can write logs to a specified file based on the configured log level. This allows for easy retrieval and download of logs, particularly useful for web applications.

### Log Collection

Collected logs can be accessed and displayed in the UI, enabling developers to show logs for user review or debugging purposes.