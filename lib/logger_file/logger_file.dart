import 'package:logger/logger.dart';
import 'package:logger_package/logger_file/platform_import.dart';

class FileLogger {
  final String filePath;
  final List<Level> logLevels;

  FileLogger({required this.filePath, required this.logLevels});

  Future<void> logToFile(Object? message, Level level) async {
    if (!shouldLog(level)) return;

    // Prepare log message with timestamp
    final timestamp = DateTime.now().toIso8601String();
    final logMessage = '[$timestamp] [$level] $message\n';

    downloadLogFile(logMessage, filePath);

  }

  bool shouldLog(Level level) {
    return logLevels.contains(level);
  }


}
