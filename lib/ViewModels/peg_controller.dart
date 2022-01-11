import 'package:flutter/cupertino.dart';
import 'package:pegsolitaire/Models/peg.dart';

class PegController extends ChangeNotifier {
  Peg peg;
  final double pegSize;

  PegController({required this.peg, required this.pegSize});

  set changePegState(PegState state) {
    peg.state = state;
    notifyListeners();
  }

  Color get color {
    return peg.color;
  }
}
