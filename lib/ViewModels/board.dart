import 'package:flutter/cupertino.dart';
import 'package:pegsolitaire/Models/board_settings.dart';
import 'package:pegsolitaire/Models/move.dart';
import 'package:pegsolitaire/Models/peg.dart';

class Board extends ChangeNotifier {
  BoardSettings settings;
  List<Peg> _pegs = [];
  List<Move> _movesHistory = [];
  List<Move> _moves = [];

  Board({required this.settings}) {
    distributeGame();
  }

  void distributeGame() {
    for (var i = 0; i < settings.size; i++) {
      for (var j = 1; j <= settings.size; j++) {
        int index = i * settings.size + j;
        PegState pegState = PegState.full;
        if (settings.empty.contains(index)) {
          pegState = PegState.empty;
        }
        if (settings.blank.contains(index)) {
          pegState = PegState.blank;
        }
        _pegs.add(Peg(
          index: index,
          state: pegState,
        ));
      }
    }
    notifyListeners();
  }

  Peg? get selectedPeg {
    try {
      return _pegs.firstWhere((element) => element.state == PegState.selected);
    } catch (e) {}
  }

  List<Peg> get possibleMoves {
    return _pegs
        .where((element) => element.state == PegState.possible)
        .toList();
  }

  int get itemsCount {
    return settings.size * settings.size;
  }

  void undoMove() {
    if (_movesHistory.isNotEmpty) {
      Move move = _movesHistory.removeLast();
      changePegState(move.destination, PegState.empty);
      changePegState(move.medium, PegState.full);
      changePegState(move.original, PegState.full);
    }
  }

  void resetGame() {
    _movesHistory = [];
    _moves = [];
    for (var item in _pegs) {
      if (settings.empty.contains(item.index)) {
        changePegState(item.index, PegState.empty);
      } else {
        if (item.state != PegState.blank)
          changePegState(item.index, PegState.full);
      }
    }
    notifyListeners();
  }

  List<Peg> get fullPegs {
    return _pegs
        .where((element) =>
            element.state == PegState.full ||
            element.state == PegState.selected)
        .toList();
  }

  int get moves {
    return _movesHistory.length;
  }

  int get fullPegsCount {
    return fullPegs.length;
  }

  int get totallPegs {
    return itemsCount - settings.empty.length - settings.blank.length;
  }

  bool get gameEnded {
    for (var element in fullPegs) {
      if (possiblePegMoves(element.index).isNotEmpty) return false;
    }
    return possibleMoves.isEmpty;
  }

  Peg pegAtIndex(int index) {
    return _pegs.firstWhere((element) => element.index == index,
        orElse: () => Peg(index: 0, state: PegState.empty));
  }

  changePegState(int index, PegState status) {
    _pegs.firstWhere((element) => element.index == index).state = status;
    notifyListeners();
  }

  PegState pegClicked(int index) {
    Peg peg = pegAtIndex(index);

    switch (peg.state) {
      case PegState.full:
        return fullPegClicked(index);
      case PegState.empty:
        return emptyPegClicked(index);

      case PegState.possible:
        return possiblePegClicked(index);
      case PegState.blank:
        break;
      case PegState.selected:
        break;
    }
    return peg.state;
  }

  // pegs clicked

  PegState emptyPegClicked(int index) {
    clearSelectedPeg();
    clearPossiblePegs();
    notifyListeners();
    return PegState.empty;
  }

  PegState fullPegClicked(int index) {
    clearPossiblePegs();
    changePegState(index, PegState.selected);

    _moves = possiblePegMoves(index);
    validateMoves();
    return PegState.selected;
  }

  PegState possiblePegClicked(int index) {
    Move move = _moves.firstWhere((element) => element.destination == index);
    _movesHistory.add(move);
    print(move.toString());

    changePegState(move.original, PegState.empty);
    changePegState(move.medium, PegState.empty);
    changePegState(move.destination, PegState.full);
    clearPossiblePegs();
    _moves.clear();

    notifyListeners();
    return PegState.full;
  }

  // settings tweaking

  clearPossiblePegs() {
    possibleMoves.forEach((element) {
      changePegState(element.index, PegState.empty);
    });
    _moves.clear();
    clearSelectedPeg();
    notifyListeners();
  }

  clearSelectedPeg() {
    if (selectedPeg != null) changePegState(selectedPeg!.index, PegState.full);
  }

  validateMoves() {
    _moves.forEach((element) {
      changePegState(element.destination, PegState.possible);
    });

    notifyListeners();
  }

  // assistive functions

  List<Move> possiblePegMoves(int index) {
    List<Move> res = [];
    // Top check
    int? topIndex =
        index - (settings.size * 2) > 0 ? index - (settings.size * 2) : null;
    if (topIndex != null)
      res.add(Move(
        destination: topIndex,
        direction: Direction.Top,
        original: index,
      ));

    // Bottom check
    int? bottomIndex = index + (settings.size * 2) <= itemsCount
        ? index + (settings.size * 2)
        : null;

    if (bottomIndex != null)
      res.add(Move(
        destination: bottomIndex,
        direction: Direction.Bottom,
        original: index,
      ));

    // Left check
    int possibleIndex = (index - 2) % settings.size;
    int? leftIndex = possibleIndex != settings.size - 1 && possibleIndex != 0
        ? index - 2
        : null;

    if (leftIndex != null)
      res.add(Move(
        destination: leftIndex,
        direction: Direction.Left,
        original: index,
      ));

    // Right check

    possibleIndex = (index + 2) % settings.size;
    int? rightIndex =
        possibleIndex != 1 && possibleIndex != 2 ? index + 2 : null;

    if (rightIndex != null)
      res.add(Move(
        destination: rightIndex,
        direction: Direction.Right,
        original: index,
      ));
    res.removeWhere((element) =>
        !(pegAtIndex(element.destination).state == PegState.empty &&
            pegAtIndex(element.medium).state == PegState.full));
    //print("possibble moves for $index are " + res.length.toString());
    return res;
  }
}
