class Album {
  const Album({required this.id, required this.name, required this.itemCount, this.isSelected = true});
  final String id;
  final String name;
  final int itemCount;
  final bool isSelected;
}
