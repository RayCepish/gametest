import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:game_test/core/constants/app_images.dart';

class ImagePreloadService {
  static Map<String, Uint8List>? _decoded;

  /// Викликається ДО runApp(), але ПІСЛЯ ensureInitialized()
  static Future<void> preloadAllInIsolate() async {
    final images = AppImages.all;

    // decode everything in isolate
    _decoded = await compute(_decodeImagesBatch, images);
  }

  /// Викликати всередині MyApp → кеш у GPU
  static Future<void> precacheGpu(BuildContext context) async {
    final map = _decoded;
    if (map == null) return;

    for (final entry in map.entries) {
      await precacheImage(MemoryImage(entry.value), context);
    }
  }
}

Future<Map<String, Uint8List>> _decodeImagesBatch(List<String> paths) async {
  final result = <String, Uint8List>{};

  for (final path in paths) {
    final data = await rootBundle.load(path);
    result[path] = data.buffer.asUint8List();
  }

  return result;
}
