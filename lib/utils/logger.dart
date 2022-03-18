import 'package:inbox_memo/providers/flavor_provoder.dart';
import 'package:intl/intl.dart';
import 'package:stack_trace/stack_trace.dart' show Trace;

enum LogLevel {
  debug,
  info,
  warn,
  error,
}

class Logger {
  Logger(this._flavor);

  final Flavor _flavor;

  void debug({String message = ''}) {
    if (_flavor == Flavor.prd) return;
    const level = 1;
    final frames = Trace.current(level).frames;
    final frame = frames.isEmpty ? null : frames.first;
    _output(LogLevel.debug, '$frame $message');
  }

  void info({String message = ''}) {
    const level = 1;
    final frames = Trace.current(level).frames;
    final frame = frames.isEmpty ? null : frames.first;
    _output(LogLevel.info, '$frame $message');
  }

  void warning({String message = ''}) {
    const level = 1;
    final frames = Trace.current(level).frames;
    final frame = frames.isEmpty ? null : frames.first;
    _output(LogLevel.warn, '$frame $message');
  }

  void error({String message = ''}) {
    const level = 1;
    final frames = Trace.current(level).frames;
    final frame = frames.isEmpty ? null : frames.first;
    _output(LogLevel.error, '$frame $message');
  }

  void _output(LogLevel logLevel, String logMessage) {
    final String nowDateString =
        DateFormat('yyyy/MM/dd HH:mm:ss').format(DateTime.now());
    final String logLevelString =
        logLevel.toString().split('.')[1].toUpperCase();
    print('[$nowDateString][$logLevelString] $logMessage');
  }
}
