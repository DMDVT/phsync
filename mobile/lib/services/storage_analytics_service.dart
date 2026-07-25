import 'dart:io';
import 'package:photo_manager/photo_manager.dart';
class StorageSummary { const StorageSummary({required this.photos,required this.videos,required this.totalBytes,required this.duplicates}); final int photos,videos,totalBytes,duplicates; }
class StorageAnalyticsService {
  Future<StorageSummary> scan() async { int photos=0,videos=0,bytes=0; final albums=await PhotoManager.getAssetPathList(type:RequestType.common); final seen=<String>{}; int duplicates=0;
    for(final album in albums){ final count=await album.assetCountAsync; final assets=await album.getAssetListRange(start:0,end:count); for(final a in assets){ if(a.type==AssetType.video) videos++; else photos++; final f=await a.file; if(f!=null){bytes+=await f.length(); final key='${await f.length()}:${a.width}x${a.height}'; if(!seen.add(key)) duplicates++;}}}
    return StorageSummary(photos:photos,videos:videos,totalBytes:bytes,duplicates:duplicates);
  }
}
