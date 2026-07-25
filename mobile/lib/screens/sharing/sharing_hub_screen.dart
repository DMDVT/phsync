import 'package:flutter/material.dart';
import '../../services/api_service.dart';
class SharingHubScreen extends StatefulWidget { const SharingHubScreen({super.key}); @override State<SharingHubScreen> createState()=>_State(); }
class _State extends State<SharingHubScreen>{ final api=ApiService(); late Future<List<dynamic>> pending=api.pendingShares();
 @override Widget build(BuildContext context)=>Scaffold(appBar:AppBar(title:const Text('Sharing')),body:FutureBuilder<List<dynamic>>(future:pending,builder:(c,s){if(!s.hasData)return const Center(child:CircularProgressIndicator()); if(s.data!.isEmpty)return const Center(child:Text('No pending shares')); return ListView(children:[for(final x in s.data!) ListTile(leading:Icon(x['media_type']=='video'?Icons.videocam:Icons.photo),title:Text(x['file_name']),subtitle:Text(x['caption']??'Shared media'),trailing:const Icon(Icons.download))]);})); }
