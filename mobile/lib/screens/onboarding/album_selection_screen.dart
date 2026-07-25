import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/album.dart';
import '../../providers/gallery_provider.dart';

class AlbumSelectionScreen extends ConsumerStatefulWidget {
  const AlbumSelectionScreen({super.key});
  @override ConsumerState<AlbumSelectionScreen> createState() => _AlbumSelectionScreenState();
}
class _AlbumSelectionScreenState extends ConsumerState<AlbumSelectionScreen> {
  late Future<List<Album>> albums;
  final selected = <String>{};
  @override void initState() { super.initState(); albums = ref.read(mediaScannerProvider).discoverAlbums(); }
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Select albums'), actions: [TextButton(onPressed: () { ref.read(selectedAlbumIdsProvider.notifier).state = {...selected}; ref.read(demoModeProvider.notifier).state = false; ref.invalidate(galleryProvider); Navigator.pop(context); }, child: const Text('Done'))]), body: FutureBuilder<List<Album>>(future: albums, builder: (_, snapshot) {
    if (snapshot.connectionState != ConnectionState.done) return const Center(child: CircularProgressIndicator());
    final data = snapshot.data ?? const <Album>[];
    if (data.isEmpty) return const Center(child: Padding(padding: EdgeInsets.all(24), child: Text('No albums available. Grant photo-library permission and try again.')));
    return ListView(children: [CheckboxListTile(title: const Text('Select all'), value: selected.length == data.length, onChanged: (value) => setState(() { selected.clear(); if (value == true) selected.addAll(data.map((e) => e.id)); })), ...data.map((album) => CheckboxListTile(value: selected.contains(album.id), title: Text(album.name), subtitle: Text('${album.itemCount} items'), secondary: const Icon(Icons.photo_album_outlined), onChanged: (value) => setState(() => value == true ? selected.add(album.id) : selected.remove(album.id))))]);
  }));
}
