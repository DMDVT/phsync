import 'dart:typed_data';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/media_item.dart';
import '../services/media_scanner.dart';

final demoModeProvider = StateProvider<bool>((ref) => true);
final mediaScannerProvider = Provider((ref) => MediaScanner());
final selectedAlbumIdsProvider = StateProvider<Set<String>>((ref) => <String>{});

final galleryProvider = FutureProvider<List<MediaItem>>((ref) async {
  if (ref.watch(demoModeProvider)) {
    return List.generate(48, (index) => MediaItem(
      id: index,
      fileName: 'Demo ${index + 1}',
      createdAt: DateTime.now().subtract(Duration(hours: index * 7)),
      mediaType: index % 9 == 0 ? 'video' : 'photo',
      thumbnailBytes: _demoPixel(index),
      tags: index % 4 == 0 ? const ['Nature'] : const ['People'],
    ));
  }
  return ref.read(mediaScannerProvider).scanSelected(ref.watch(selectedAlbumIdsProvider));
});

Uint8List _demoPixel(int seed) {
  // Transparent 1x1 PNG; UI paints a fallback background behind it.
  return Uint8List.fromList(const [137,80,78,71,13,10,26,10,0,0,0,13,73,72,68,82,0,0,0,1,0,0,0,1,8,6,0,0,0,31,21,196,137,0,0,0,13,73,68,65,84,8,215,99,96,96,96,248,15,0,1,4,1,0,112,32,101,11,0,0,0,0,73,69,78,68,174,66,96,130]);
}
