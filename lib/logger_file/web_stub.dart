import 'dart:io';

import 'package:path_provider/path_provider.dart';

void downloadLogFile(String logMessage, String filePath) async {
  // Mobile or Desktop platforms
  final directory = await getApplicationDocumentsDirectory();
  final file = File('${directory.path}/$filePath');

  // Append the log message to the file
  await file.writeAsString(logMessage, mode: FileMode.append);
}
