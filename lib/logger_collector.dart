class LogCollector {
  final List<Object?> _logs = [];

  void addLog(Object? log) {
    _logs.add(log);
  }

  List<Object?> getLogs() {
    return List.unmodifiable(_logs); // Return a copy of the logs
  }

  void clearLogs() {
    _logs.clear();
  }
}
