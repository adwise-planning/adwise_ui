import 'dart:io';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

class AppLogger {
  static final AppLogger _instance = AppLogger._internal();
  late Logger _logger;
  File? _logFile; // Change from late to nullable

  factory AppLogger() => _instance;

  AppLogger._internal() {
    _logger = Logger(
      printer: PrettyPrinter(
        methodCount: 2,
        errorMethodCount: 5,
        lineLength: 80,
        colors: true,
        printEmojis: true,
        printTime: true,
      ),
    );

    // _initializeLogFile();
  }

  Future<void> _initializeLogFile() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      print('Log file directory: ${directory.path}');
      _logFile = File('${directory.path}/app_logs.txt');

      if (!(await _logFile!.exists())) {
        await _logFile!.create();
      }
    } catch (e) {
      _logger.e("Failed to initialize log file", error: e);
    }
  }

  void info(String message) async {
    final callerInfo = _getCallerInfo();
    final logMessage = "[INFO] $callerInfo $message";
    _logger.i(logMessage);
    // await _writeToFile(logMessage);
  }

  void warn(String message) async {
    final callerInfo = _getCallerInfo();
    final logMessage = "[WARNING] $callerInfo $message";
    _logger.w(logMessage);
    // await _writeToFile(logMessage);
  }

  void error(String message, [dynamic error, StackTrace? stackTrace]) async {
    final callerInfo = _getCallerInfo();
    final logMessage = "[ERROR] $callerInfo $message \n$error\n$stackTrace";
    _logger.e(logMessage, error: error, stackTrace: stackTrace);
    // await _writeToFile(logMessage);
  }

  Future<void> _writeToFile(String message) async {
    final timestamp = DateTime.now().toIso8601String();
    
    if (_logFile == null) {
      await _initializeLogFile(); // Ensure it's initialized
    }
    
    if (_logFile != null) {
      await _logFile!.writeAsString('$timestamp - $message\n', mode: FileMode.append);
    } else {
      _logger.e("Log file is still null, cannot write log.");
    }
  }

  Future<String> getLogs() async {
    return _logFile != null ? await _logFile!.readAsString() : "No logs available";
  }

  String _getCallerInfo() {
    try {
      final stackTrace = StackTrace.current;
      final stackLines = stackTrace.toString().split("\n");

      for (var line in stackLines) {
        if (!line.contains("logger_service.dart") && line.contains(".dart")) {
          final match = RegExp(r'(\S+\.dart):(\d+):(\d+)').firstMatch(line);
          if (match != null) {
            final fileName = match.group(1)?.split('/').last ?? 'Unknown';
            final lineNumber = match.group(2) ?? '??';
            return "[$fileName:$lineNumber]";
          }
        }
      }
    } catch (e) {
      return "[Unknown Caller]";
    }
    return "[Unknown Caller]";
  }
}
