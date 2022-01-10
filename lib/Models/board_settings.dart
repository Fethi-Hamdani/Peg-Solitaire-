class BoardSettings {
  int size;
  List<int> blank;
  List<int> empty;
  BoardSettings({
    required this.size,
    this.blank = const [],
    this.empty = const [],
  });
}
