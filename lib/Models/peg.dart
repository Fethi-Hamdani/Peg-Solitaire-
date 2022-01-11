import 'package:flutter/material.dart';
import 'package:pegsolitaire/Constantes/colors.dart';

enum PegState { full, empty, possible, blank, selected }

class Peg {
  int index;
  PegState state;
  Peg({
    required this.index,
    required this.state,
  });

  Color get color {
    switch (state) {
      case PegState.full:
        return blue;
      case PegState.empty:
        return greyScale1;
      case PegState.possible:
        return green;
      case PegState.blank:
        return red;
      case PegState.selected:
        return yellow;
    }
  }
}
