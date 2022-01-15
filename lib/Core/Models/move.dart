
import 'package:pegsolitaire/Core/Enums/directions.dart';

class Move {
  Direction direction;
  int original;
  int destination;
  late int medium;
  Move({
    required this.direction,
    required this.original,
    required this.destination,
  }) {
    switch (direction) {
      case Direction.Top:
        medium = ((original + destination) / 2).round();
        break;
      case Direction.Bottom:
        medium = ((original + destination) / 2).round();
        break;
      case Direction.Left:
        medium = original - 1;
        break;
      case Direction.Right:
        medium = original + 1;
        break;
    }
  }

  @override
  String toString() {
    return 'Move(direction: $direction, original: $original, destination: $destination, medium: $medium)';
  }
}
