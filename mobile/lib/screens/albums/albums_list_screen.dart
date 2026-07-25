import 'package:flutter/material.dart';

class AlbumsListScreen extends StatelessWidget {
  const AlbumsListScreen({super.key});

  static const albums = <(String, int)>[
    ('Camera', 0),
    ('Screenshots', 0),
    ('Favorites', 0),
    ('Received', 0),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Albums'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.25,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: albums.length,
        itemBuilder: (context, index) {
          final album = albums[index];

          return Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Icon(
                    Icons.photo_album,
                    size: 42,
                  ),
                  const Spacer(),
                  Text(
                    album.$1,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text('${album.$2} items'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
