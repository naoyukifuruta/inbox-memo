import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stack_trace/stack_trace.dart';
import '../providers/flavor_provoder.dart';

enum LogLevel {
  debug,
  info,
  warning,
  error,
}

class Logger {
  factory Logger() => _singleton;
  Logger._();
  static final _singleton = Logger._();

  var _flavor = Flavor.prd;

  void setFlavor(Flavor flavor) {
    _flavor = flavor;
  }

  void debug(String message) {
    if (_flavor == Flavor.prd) {
      // リリースビルド時はログを出さない
      return;
    }

    const level = 1;
    final frames = Trace.current(level).frames;
    final frame = frames.isEmpty ? null : frames.first;

    _output(LogLevel.debug, message, frame);
  }

  void info(String message) {
    if (_flavor == Flavor.prd) {
      return;
    }

    const level = 1;
    final frames = Trace.current(level).frames;
    final frame = frames.isEmpty ? null : frames.first;

    _output(LogLevel.info, message, frame);
  }

  void warning(String message) {
    if (_flavor == Flavor.prd) {
      return;
    }

    const level = 1;
    final frames = Trace.current(level).frames;
    final frame = frames.isEmpty ? null : frames.first;

    _output(LogLevel.warning, message, frame);
  }

  void error(String message) {
    if (_flavor == Flavor.prd) {
      return;
    }

    const level = 1;
    final frames = Trace.current(level).frames;
    final frame = frames.isEmpty ? null : frames.first;

    _output(LogLevel.error, message, frame);
  }

  void _output(LogLevel logLevel, String logMessage, Frame? frame) {
    final nowDateString =
        DateFormat('yyyy/MM/dd HH:mm:ss').format(DateTime.now());
    final logLevelString = logLevel.toString().split('.')[1].toUpperCase();
    debugPrint('👻 $logLevelString $nowDateString [$frame] $logMessage');
  }
}
