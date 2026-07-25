import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  @override State<SearchScreen> createState() => _SearchScreenState();
}
class _SearchScreenState extends State<SearchScreen> {
  final controller = TextEditingController();
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Search')), body: Padding(padding: const EdgeInsets.all(16), child: Column(children: [SearchBar(controller: controller, hintText: 'Beach sunset, receipt, red car…', leading: const Icon(Icons.search), onSubmitted: (_) => setState(() {})), const SizedBox(height: 24), Wrap(spacing: 8, runSpacing: 8, children: ['People','Places','Food','Animals','Documents','Screenshots','Architecture'].map((tag) => ActionChip(label: Text(tag), onPressed: () { controller.text = tag; setState(() {}); })).toList()), const SizedBox(height: 32), Text(controller.text.isEmpty ? 'Search uses filenames, dates, tags, OCR text and semantic embeddings.' : 'Semantic result pipeline ready for “${controller.text}”.')])));
}
