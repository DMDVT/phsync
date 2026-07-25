import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import '../../models/media_item.dart';

class PhotoViewerScreen extends StatefulWidget {
  const PhotoViewerScreen({required this.items, required this.initialIndex, super.key});
  final List<MediaItem> items;
  final int initialIndex;
  @override State<PhotoViewerScreen> createState() => _PhotoViewerScreenState();
}

class _PhotoViewerScreenState extends State<PhotoViewerScreen> {
  late final PageController controller = PageController(initialPage: widget.initialIndex);
  late int index = widget.initialIndex;

  @override
  Widget build(BuildContext context) {
    final item = widget.items[index];
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor: Colors.black, foregroundColor: Colors.white, title: Text(item.fileName), actions: const [Icon(Icons.favorite_border), SizedBox(width: 16), Icon(Icons.more_vert), SizedBox(width: 8)]),
      body: PageView.builder(
        controller: controller,
        itemCount: widget.items.length,
        onPageChanged: (value) => setState(() => index = value),
        itemBuilder: (_, i) {
          final bytes = widget.items[i].thumbnailBytes;
          if (bytes == null) return const Center(child: Icon(Icons.image, color: Colors.white, size: 80));
          return PhotoView(imageProvider: MemoryImage(Uint8List.fromList(bytes)), backgroundDecoration: const BoxDecoration(color: Colors.black));
        },
      ),
      bottomNavigationBar: SafeArea(child: Padding(padding: const EdgeInsets.all(16), child: Text('${item.createdAt.toLocal()} • ${item.tags.join(', ')}', style: const TextStyle(color: Colors.white70), textAlign: TextAlign.center))),
    );
  }
}
