class MediaItem {
  const MediaItem({
    required this.id,
    required this.fileName,
    required this.createdAt,
    required this.mediaType,
    this.assetId,
    this.thumbnailBytes,
    this.width = 0,
    this.height = 0,
    this.isFavorite = false,
    this.isArchived = false,
    this.tags = const [],
  });

  final int id;
  final String? assetId;
  final String fileName;
  final DateTime createdAt;
  final String mediaType;
  final List<int>? thumbnailBytes;
  final int width;
  final int height;
  final bool isFavorite;
  final bool isArchived;
  final List<String> tags;
}
