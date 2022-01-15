import 'package:flutter/cupertino.dart';
import 'package:pegsolitaire/Core/Enums/peg_state.dart';
import 'package:pegsolitaire/Core/Models/board.dart';
import 'package:pegsolitaire/Core/Models/board_settings.dart';
import 'package:pegsolitaire/Core/Models/move.dart';
import 'package:pegsolitaire/Core/Models/peg.dart';

class CasualGame extends ChangeNotifier {
  BoardSettings settings;
  List<Move> _movesHistory = [];
  List<Move> _moves = [];
  late Board board;

  Stopwatch timer = Stopwatch();

  CasualGame({required this.settings}) {
    board = Board(settings: settings);
  }

  addMoveToHistory({required Move move}) {
    _movesHistory.add(move);
  }

  int get movesMade {
    return _movesHistory.length;
  }

  void undoMove() {
    if (_movesHistory.isNotEmpty) {
      board.undoMove(_movesHistory.last);
      notifyListeners();
    }
  }

  void resetGame() {
    _movesHistory = [];
    _moves = [];
    timer.reset();
    board.resetGame();
    notifyListeners();
  }

  PegState pegClicked(int index) {
    Peg peg = board.pegAtIndex(index);
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

  void validateMoves() {
    _moves.forEach((element) {
      board.changePegState(element.destination, PegState.possible);
    });
  }

  PegState emptyPegClicked(int index) {
    board.clearSelectedPeg();
    board.clearPossiblePegs();
    _moves.clear();
    notifyListeners();
    return PegState.empty;
  }

  PegState fullPegClicked(int index) {
    if (!timer.isRunning) {
      timer.start();
    }
    board.clearPossiblePegs();
    _moves.clear();
    board.changePegState(index, PegState.selected);
    _moves = board.possiblePegMoves(index);
    validateMoves();
    notifyListeners();
    return PegState.selected;
  }

  PegState possiblePegClicked(int index) {
    Move move = _moves.firstWhere((element) => element.destination == index);
    addMoveToHistory(move: move);
    print("move made is " + move.toString());

    board.pegJump(move: move);
    notifyListeners();
    return PegState.full;
  }
}
