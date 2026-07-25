import 'package:photo_manager/photo_manager.dart';
class ContactMediaMatch { const ContactMediaMatch(this.contactName,this.assetIds,this.confidence); final String contactName; final List<String> assetIds; final double confidence; }
class MessagingContactSyncService {
  Future<List<AssetPathEntity>> messagingAlbums() async { final albums=await PhotoManager.getAssetPathList(type:RequestType.common); const keys=['whatsapp','telegram','signal','instagram']; return albums.where((a)=>keys.any((k)=>a.name.toLowerCase().contains(k))).toList(); }
  Future<ContactMediaMatch> manuallyAssign(String contactName,List<AssetEntity> assets) async => ContactMediaMatch(contactName,assets.map((e)=>e.id).toList(),1);
  Future<ContactMediaMatch> inferByTimeWindow(String contactName,List<AssetEntity> candidates,DateTime chatTime,{Duration window=const Duration(minutes:5)}) async { final ids=candidates.where((a)=>a.createDateTime.difference(chatTime).abs()<=window).map((e)=>e.id).toList(); return ContactMediaMatch(contactName,ids,ids.isEmpty?0:0.55); }
}
