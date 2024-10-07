// web_specific.dart
import 'dart:html' as html;
export 'web_stub.dart' if (dart.library.html) 'web_specific.dart';

void downloadLogFile(String logMessage, String filePath) {
  final blob = html.Blob([logMessage], 'text/plain');
  final url = html.Url.createObjectUrlFromBlob(blob);

  // ignore_for_file: unused_local_variable
  final html.AnchorElement anchor = html.AnchorElement(href: url)
    ..setAttribute('download', 'logs.txt')
    ..click();
  html.Url.revokeObjectUrl(url);
}
