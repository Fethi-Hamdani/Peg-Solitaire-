import 'package:flutter/material.dart';
import 'package:pegsolitaire/Core/Constantes/colors.dart';
import 'package:pegsolitaire/Core/Enums/peg_state.dart';

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
        return Color(0xFF00ADB5);
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
