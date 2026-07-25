import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/media_item.dart';
import '../../providers/gallery_provider.dart';
import 'photo_viewer_screen.dart';

class GalleryGridScreen extends ConsumerStatefulWidget {
  const GalleryGridScreen({super.key});
  @override ConsumerState<GalleryGridScreen> createState() => _GalleryGridScreenState();
}

class _GalleryGridScreenState extends ConsumerState<GalleryGridScreen> {
  double extent = 120;

  @override
  Widget build(BuildContext context) {
    final gallery = ref.watch(galleryProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('PhotoSync'), actions: [IconButton(onPressed: () => ref.invalidate(galleryProvider), icon: const Icon(Icons.refresh))]),
      body: gallery.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Could not load media: $error')),
        data: (items) => GestureDetector(
          onScaleUpdate: (details) => setState(() => extent = (extent / details.scale).clamp(80, 220)),
          child: GridView.builder(
            padding: const EdgeInsets.all(2),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: extent, mainAxisSpacing: 2, crossAxisSpacing: 2),
            itemCount: items.length,
            itemBuilder: (context, index) => MediaTile(item: items[index], onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => PhotoViewerScreen(items: items, initialIndex: index)))),
          ),
        ),
      ),
    );
  }
}

class MediaTile extends StatelessWidget {
  const MediaTile({required this.item, required this.onTap, super.key});
  final MediaItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        child: Stack(fit: StackFit.expand, children: [
          Container(color: Theme.of(context).colorScheme.surfaceContainerHighest, child: item.thumbnailBytes == null ? const Icon(Icons.image) : Image.memory(Uint8List.fromList(item.thumbnailBytes!), fit: BoxFit.cover, errorBuilder: (_, __, ___) => const Icon(Icons.image))),
          if (item.mediaType == 'video') const Positioned(right: 6, top: 6, child: Icon(Icons.play_circle_fill, color: Colors.white)),
          if (item.isFavorite) const Positioned(left: 6, top: 6, child: Icon(Icons.favorite, color: Colors.white, size: 18)),
        ]),
      );
}
