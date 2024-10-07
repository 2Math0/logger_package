import 'dart:developer';
import 'package:logger/logger.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:logger_package/logger_collector.dart';
import 'package:logger_package/tags.dart';
import 'logger_file/logger_file.dart';

/// AppLogger is a singleton class that provides an easy-to-use logging system.
/// It supports log levels and optional tagging for each log message.
/// It also adjusts the logging behavior on different platforms, such as Flutter Web.
///
/// Example usage:
/// ```dart
/// AppLogger().debug('This is a debug message');
/// AppLogger().info('This is an info message', tag: 'AppStart');
/// ```
///
/// ### Available log levels:
/// - `debug`: Debug-level logs (only shown in development)
/// - `info`: Information-level logs
/// - `warning`: Warning-level logs
/// - `error`: Error-level logs
/// - `fatal`: Critical error logs
///
/// ### Flutter Web Behavior:
/// - Only `warning` and above will be printed on Flutter Web.

class LoggerConfig {
  final bool enableLogging;
  final Level logLevel;
  final LogPrinter? customPrinter;
  final bool enableFileLogging;
  final List<Level> fileLogLevels;
  final String? filePath;

  LoggerConfig({
    this.enableLogging = true,
    this.logLevel = Level.trace,
    this.customPrinter,
    this.enableFileLogging = false,
    this.fileLogLevels = const [Level.error],
    this.filePath,
  });
}

class AppLogger {
  static final AppLogger _instance = AppLogger._internal();
  late Logger _logger;
  late LoggerConfig _config;
  final LogCollector _logCollector = LogCollector();
  FileLogger? _fileLogger;

  factory AppLogger() => _instance;

  AppLogger._internal() {
    _config = LoggerConfig(); // Default config
    _initializeLogger();
  }

  /// Configures and reinitialized the logger
  void configure(LoggerConfig config) {
    if (_config.enableFileLogging) {
      _fileLogger = FileLogger(
          filePath: _config.filePath ?? '', logLevels: _config.fileLogLevels);
    }
    _config = config;

    _initializeLogger();
  }

  void _initializeLogger() {
    // Only warnings and above will be shown on Flutter Web
    Level effectiveLogLevel = kIsWeb ? Level.warning : _config.logLevel;

    _logger = Logger(
      level: effectiveLogLevel,
      printer: _config.customPrinter ??
          PrettyPrinter(
            methodCount: 8,
            errorMethodCount: 8,
            lineLength: 120,
            colors: true,
            printEmojis: true,
            noBoxingByDefault: false,
            stackTraceBeginIndex: 3,
          ),
    );
  }

  void _log(Level level, Object? message, {Tag? tag, Function()? logFunction}) {
    try {
      if (_config.enableLogging && level.index >= _config.logLevel.index) {
        final logMessage = '[${tag ?? "AppLogger"}] $message';

        _logCollector.addLog(message); // Collect the log
        _fileLogger?.logToFile(message, level); // Log to file if enabled

        if (logFunction != null) {
          _logger.log(level, logFunction());
        } else {
          _logger.log(level, logMessage);
        }
      }
    } catch (e) {
      log("Logging Error: $e");
    }
  }

  /// Debug log
  void debug(Object? message, {Tag? tag}) =>
      _log(Level.debug, message, tag: tag);

  /// Info log
  void info(Object? message, {Tag? tag}) => _log(Level.info, message, tag: tag);

  /// Warning log
  void warning(Object? message, {Tag? tag}) =>
      _log(Level.warning, message, tag: tag);

  /// Error log
  void error(Object? message, {Tag? tag}) =>
      _log(Level.error, message, tag: tag);

  /// trace log
  void trace(Object message, {Tag? tag}) =>
      _log(Level.trace, message, tag: tag);

  /// Fatal log (critical errors)
  void fatal(Object? message, {Tag? tag}) =>
      _log(Level.fatal, message, tag: tag);

  /// Lazy logging: pass in a function that returns a message
  void lazyLog(Level level, Function() logFunction, {Tag? tag}) =>
      _log(level, null, logFunction: logFunction);

  /// Optionally log with metadata (custom tag, additional context)
  void logWithMetadata(Level level, Object? message, {Tag? tag}) =>
      _log(level, message, tag: tag);

  /// Retrieve logs for UI
  List<Object?> getLogs() => _logCollector.getLogs();

  /// Clear collected logs
  void clearLogs() => _logCollector.clearLogs();
}
