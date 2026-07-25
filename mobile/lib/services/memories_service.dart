import '../database/local_database.dart';
class MemoryCollection { const MemoryCollection(this.title,this.items); final String title; final List<MediaData> items; }
class MemoriesService { MemoriesService(this.db); final LocalDatabase db;
  Future<List<MemoryCollection>> build(DateTime now) async { final all=await db.gallery(); final onThisDay=all.where((m)=>m.createdAt.month==now.month&&m.createdAt.day==now.day&&m.createdAt.year<now.year).toList(); final recent=all.where((m)=>now.difference(m.createdAt).inDays<=7).toList(); return [if(onThisDay.isNotEmpty) MemoryCollection('On this day',onThisDay),if(recent.isNotEmpty) MemoryCollection('Last 7 days',recent)]; }
}
