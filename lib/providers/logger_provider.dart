import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inbox_memo/providers/flavor_provoder.dart';

import '../utils/logger.dart';

final loggerProvider = Provider<Logger>((ref) {
  final logger = Logger();
  logger.setFlavor(ref.read(flavorProvider));
  return logger;
});
