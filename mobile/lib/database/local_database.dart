import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'tables.dart';

part 'local_database.g.dart';

@DriftDatabase(tables: [Media, Albums, AlbumMedia, Tags, MediaTags, Faces, MediaFaces, MediaOcr, MediaEmbeddings, ReceivedMedia, SyncState, ContactSyncSelections, CompressionJobs])
class LocalDatabase extends _$LocalDatabase {
  LocalDatabase() : super(_open());
  @override int get schemaVersion => 2;

  Future<void> upsertMedia(MediaCompanion item) => into(media).insertOnConflictUpdate(item);

  Future<List<MediaData>> gallery({String? query}) {
    final statement = select(media)..where((row) => row.isDeleted.equals(false) & row.isArchived.equals(false));
    if (query != null && query.trim().isNotEmpty) {
      statement.where((row) => row.fileName.like('%${query.trim()}%'));
    }
    statement.orderBy([(row) => OrderingTerm.desc(row.createdAt)]);
    return statement.get();
  }

  Future<void> setFavorite(int id, bool value) => (update(media)..where((row) => row.id.equals(id))).write(MediaCompanion(isFavorite: Value(value)));
  Future<void> archive(int id) => (update(media)..where((row) => row.id.equals(id))).write(const MediaCompanion(isArchived: Value(true)));
  Future<void> softDelete(int id) => (update(media)..where((row) => row.id.equals(id))).write(MediaCompanion(isDeleted: const Value(true), deletedAt: Value(DateTime.now())));
}

LazyDatabase _open() => LazyDatabase(() async {
  final directory = await getApplicationDocumentsDirectory();
  return NativeDatabase.createInBackground(File(p.join(directory.path, 'photosync.sqlite')));
});
