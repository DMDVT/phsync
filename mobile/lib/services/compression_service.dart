import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

enum CompressionQuality { maximum, balanced, high }
class CompressionResult { const CompressionResult(this.path,this.originalBytes,this.compressedBytes); final String path; final int originalBytes; final int compressedBytes; int get savedBytes=>originalBytes-compressedBytes; }
class CompressionService {
  Future<CompressionResult> compressPhoto(File source,{CompressionQuality quality=CompressionQuality.balanced}) async {
    final dir=Directory(p.join((await getApplicationDocumentsDirectory()).path,'compressed')); await dir.create(recursive:true);
    final target=p.join(dir.path,'${p.basenameWithoutExtension(source.path)}.webp');
    final q=switch(quality){CompressionQuality.maximum=>68,CompressionQuality.balanced=>82,CompressionQuality.high=>92};
    final result=await FlutterImageCompress.compressAndGetFile(source.path,target,quality:q,format:CompressFormat.webp);
    if(result==null) throw StateError('Compression failed');
    return CompressionResult(result.path,await source.length(),await File(result.path).length());
  }
  Future<CompressionResult> compressVideo(File source,{CompressionQuality quality=CompressionQuality.balanced}) async {
    // Production hook: invoke platform FFmpeg with H.265/AV1 after adding ffmpeg_kit_flutter.
    final dir=Directory(p.join((await getApplicationDocumentsDirectory()).path,'compressed')); await dir.create(recursive:true);
    final target=p.join(dir.path,p.basename(source.path)); await source.copy(target);
    return CompressionResult(target,await source.length(),await File(target).length());
  }
}
