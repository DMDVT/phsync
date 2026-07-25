import 'package:flutter/material.dart';

class AlbumsListScreen extends StatelessWidget {
  const AlbumsListScreen({super.key});
  @override Widget build(BuildContext context) {
    const albums = [('Camera', 3200), ('Screenshots', 940), ('Favorites', 180), ('Nature', 122), ('People', 384), ('Documents', 66)];
    return Scaffold(appBar: AppBar(title: const Text('Albums'), actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.add))]), body: GridView.builder(padding: const EdgeInsets.all(12), gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 1.25, crossAxisSpacing: 12, mainAxisSpacing: 12), itemCount: albums.length, itemBuilder: (_, i) => Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.end, children: [const Icon(Icons.photo_album, size: 42), const Spacer(), Text(albums[i].$1, style: Theme.of(context).textTheme.titleMedium), Text('${albums[i].$2} items')]))));
  }
}
