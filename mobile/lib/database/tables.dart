import 'package:drift/drift.dart';

class Media extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get assetId => text().unique()();
  TextColumn get fileName => text().nullable()();
  IntColumn get fileSize => integer().withDefault(const Constant(0))();
  TextColumn get mediaType => text()();
  IntColumn get width => integer().withDefault(const Constant(0))();
  IntColumn get height => integer().withDefault(const Constant(0))();
  RealColumn get duration => real().nullable()();
  TextColumn get thumbnailPath => text().nullable()();
  TextColumn get contentHash => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get modifiedAt => dateTime().nullable()();
  DateTimeColumn get indexedAt => dateTime().withDefault(currentDateAndTime)();
  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();
  BoolColumn get isArchived => boolean().withDefault(const Constant(false))();
  BoolColumn get isHidden => boolean().withDefault(const Constant(false))();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get deletedAt => dateTime().nullable()();
  TextColumn get sourceFolder => text().nullable()();
}

class Albums extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get type => text().withDefault(const Constant('manual'))();
  IntColumn get coverMediaId => integer().nullable()();
  TextColumn get rulesJson => text().nullable()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class AlbumMedia extends Table {
  IntColumn get albumId => integer()();
  IntColumn get mediaId => integer()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  @override Set<Column> get primaryKey => {albumId, mediaId};
}

class Tags extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().unique()();
}

class MediaTags extends Table {
  IntColumn get mediaId => integer()();
  IntColumn get tagId => integer()();
  RealColumn get confidence => real().withDefault(const Constant(1))();
  TextColumn get source => text().withDefault(const Constant('auto'))();
  @override Set<Column> get primaryKey => {mediaId, tagId};
}

class Faces extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get label => text().nullable()();
  BlobColumn get encoding => blob()();
  IntColumn get sampleMediaId => integer().nullable()();
}

class MediaFaces extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get mediaId => integer()();
  IntColumn get faceId => integer()();
  TextColumn get boundingBoxJson => text()();
  RealColumn get confidence => real()();
}

class MediaOcr extends Table {
  IntColumn get mediaId => integer()();
  TextColumn get extractedText => text()();
  TextColumn get language => text().nullable()();
  @override Set<Column> get primaryKey => {mediaId};
}

class MediaEmbeddings extends Table {
  IntColumn get mediaId => integer()();
  BlobColumn get embedding => blob()();
  @override Set<Column> get primaryKey => {mediaId};
}

class ReceivedMedia extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get senderUsername => text()();
  TextColumn get senderDisplayName => text().nullable()();
  TextColumn get filePath => text()();
  TextColumn get mediaType => text()();
  TextColumn get caption => text().nullable()();
  DateTimeColumn get receivedAt => dateTime().withDefault(currentDateAndTime)();
  TextColumn get shareId => text().unique()();
}

class SyncState extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  @override Set<Column> get primaryKey => {key};
}

class ContactSyncSelections extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get sourceType => text()();
  TextColumn get contactName => text()();
  BoolColumn get liveSync => boolean().withDefault(const Constant(true))();
  IntColumn get mediaCount => integer().withDefault(const Constant(0))();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

class CompressionJobs extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get mediaId => integer()();
  TextColumn get status => text().withDefault(const Constant('queued'))();
  TextColumn get quality => text().withDefault(const Constant('balanced'))();
  IntColumn get originalBytes => integer().withDefault(const Constant(0))();
  IntColumn get compressedBytes => integer().withDefault(const Constant(0))();
  TextColumn get error => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
