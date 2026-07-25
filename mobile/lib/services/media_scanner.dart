import 'dart:typed_data';
import 'package:photo_manager/photo_manager.dart';
import '../models/album.dart';
import '../models/media_item.dart';

class MediaScanner {
  Future<bool> requestPermission() async {
    final state = await PhotoManager.requestPermissionExtend();
    return state.isAuth || state.hasAccess;
  }

  Future<List<Album>> discoverAlbums() async {
    if (!await requestPermission()) return [];
    final paths = await PhotoManager.getAssetPathList(type: RequestType.common, filterOption: FilterOptionGroup(orders: [const OrderOption(type: OrderOptionType.createDate, asc: false)]));
    return [for (final path in paths) Album(id: path.id, name: path.name, itemCount: await path.assetCountAsync)];
  }

  Future<List<MediaItem>> scanSelected(Set<String> albumIds, {int pageSize = 200}) async {
    if (!await requestPermission()) return [];
    final paths = await PhotoManager.getAssetPathList(type: RequestType.common);
    final output = <MediaItem>[];
    for (final path in paths.where((p) => albumIds.contains(p.id))) {
      final count = await path.assetCountAsync;
      for (var start = 0; start < count; start += pageSize) {
        final assets = await path.getAssetListRange(start: start, end: (start + pageSize).clamp(0, count));
        for (final asset in assets) {
          final Uint8List? thumb = await asset.thumbnailDataWithSize(const ThumbnailSize.square(320), quality: 75);
          output.add(MediaItem(
            id: asset.id.hashCode,
            assetId: asset.id,
            fileName: asset.title ?? 'Untitled',
            createdAt: asset.createDateTime,
            mediaType: asset.type == AssetType.video ? 'video' : 'photo',
            thumbnailBytes: thumb,
            width: asset.width,
            height: asset.height,
          ));
        }
      }
    }
    output.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return output;
  }
}
