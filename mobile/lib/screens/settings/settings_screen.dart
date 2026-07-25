import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
class SettingsScreen extends StatelessWidget { const SettingsScreen({super.key});
 @override Widget build(BuildContext context)=>Scaffold(appBar:AppBar(title:const Text('Settings'),actions:[IconButton(onPressed:()=>context.push('/notifications'),icon:const Icon(Icons.notifications_outlined))]),body:ListView(children:[
  const SwitchListTile(value:true,onChanged:null,title:Text('Local-first indexing'),subtitle:Text('Photos stay on this device')),
  ListTile(leading:const Icon(Icons.ios_share),title:const Text('Sharing and received media'),onTap:()=>context.push('/sharing')),
  ListTile(leading:const Icon(Icons.lock_outline),title:const Text('Private vault'),onTap:()=>context.push('/vault')),
  ListTile(leading:const Icon(Icons.storage),title:const Text('Storage and cleanup'),onTap:()=>context.push('/storage')),
  ListTile(leading:const Icon(Icons.auto_awesome),title:const Text('Memories'),onTap:()=>context.push('/memories')),
  const ListTile(leading:Icon(Icons.compress),title:Text('Compression'),subtitle:Text('WebP photo pipeline; AV1/H.265 platform hook for video')),
  const ListTile(leading:Icon(Icons.sync),title:Text('Cross-device metadata sync'),subtitle:Text('Album names, tags, favorites and face labels only')),
  const ListTile(leading:Icon(Icons.chat_bubble_outline),title:Text('Messaging contact sync'),subtitle:Text('Manual assignment plus time-window suggestions')),
 ])); }
