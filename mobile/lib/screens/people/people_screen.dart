import 'package:flutter/material.dart';

class PeopleScreen extends StatelessWidget {
  const PeopleScreen({super.key});
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('People')), body: ListView.separated(padding: const EdgeInsets.all(16), itemCount: 6, separatorBuilder: (_, __) => const Divider(), itemBuilder: (_, i) => ListTile(leading: CircleAvatar(child: Text('${i + 1}')), title: Text(i < 2 ? ['Rahul','Mom'][i] : 'Unnamed face cluster'), subtitle: Text('${42 + i * 17} photos'), trailing: const Icon(Icons.chevron_right))));
}
