import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:html' as html; // Only for web

class FileLogger {
  final String filePath;
  final List<Level> logLevels;

  FileLogger({required this.filePath, required this.logLevels});

  Future<void> logToFile(Object? message, Level level) async {
    if (!shouldLog(level)) return;

    // Prepare log message with timestamp
    final timestamp = DateTime.now().toIso8601String();
    final logMessage = '[$timestamp] [$level] $message\n';

    if (Platform.isAndroid || Platform.isIOS || Platform.isWindows) {
      // Mobile or Desktop platforms
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/$filePath');

      // Append the log message to the file
      await file.writeAsString(logMessage, mode: FileMode.append);
    } else if (kIsWeb) {
      // Web platform
      _downloadLogFile(logMessage);
    }
  }

  bool shouldLog(Level level) {
    return logLevels.contains(level);
  }

  void _downloadLogFile(String logMessage) {
    final blob = html.Blob([logMessage], 'text/plain');
    final url = html.Url.createObjectUrlFromBlob(blob);

    // ignore_for_file: unused_local_variable
    final html.AnchorElement anchor = html.AnchorElement(href: url)
      ..setAttribute('download', 'logs.txt')
      ..click();
    html.Url.revokeObjectUrl(url);
  }
}
