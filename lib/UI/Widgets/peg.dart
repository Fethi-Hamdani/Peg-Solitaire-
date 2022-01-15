import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:pegsolitaire/Core/Constantes/colors.dart';
import 'package:pegsolitaire/Core/Enums/peg_state.dart';
import 'package:pegsolitaire/Core/Models/peg.dart';

class PegView extends StatefulWidget {
  final Peg peg;
  final double pegSize;
  final PegState Function() onClick;
  const PegView({
    Key? key,
    required this.peg,
    required this.onClick,
    required this.pegSize,
  }) : super(key: key);

  @override
  State<PegView> createState() => _PegViewState();
}

class _PegViewState extends State<PegView> {
  BoxDecoration? containerDecoration =
      BoxDecoration(borderRadius: BorderRadius.circular(360));

  @override
  Widget build(BuildContext context) {
    switch (widget.peg.state) {
      case PegState.full:
        containerDecoration = containerDecoration!.copyWith(boxShadow: [
          BoxShadow(
            blurRadius: 2,
            offset: Offset(-1, -1),
            color: widget.peg.color.mix(Colors.white, .6),
          ),
          BoxShadow(
            blurRadius: 3,
            offset: Offset(0, 0),
            color: widget.peg.color.mix(Colors.black, .3),
          )
        ], color: widget.peg.color, border: null);

        break;
      case PegState.empty:
        containerDecoration = containerDecoration!.copyWith(
            boxShadow: null,
            color: null,
            border: Border.all(color: greyScale4, width: 2));
        break;
      case PegState.possible:
        containerDecoration = containerDecoration!.copyWith(
            boxShadow: null,
            color: null,
            border: Border.all(color: greyScale4, width: 2));
        break;
      case PegState.blank:
        return SizedBox();
      case PegState.selected:
        containerDecoration = containerDecoration!.copyWith(boxShadow: [
          BoxShadow(
            blurRadius: 2,
            offset: Offset(-1, -1),
            color: widget.peg.color.mix(Colors.white, .6),
          ),
          BoxShadow(
            blurRadius: 3,
            offset: Offset(0, 0),
            color: widget.peg.color.mix(Colors.black, .3),
          )
        ], border: null, color: yellow);
        break;
    }
    return GestureDetector(
      onTap: () {
        widget.onClick();
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
        height: widget.pegSize,
        width: widget.pegSize,
        alignment: Alignment.center,

        child: AnimatedContainer(
            duration: Duration(milliseconds: 200),
            curve: Curves.ease,
            height: 15,
            width: 15,
            decoration: BoxDecoration(
                color: widget.peg.state == PegState.possible
                    ? widget.peg.color
                    : null,
                borderRadius: BorderRadius.circular(360))),
        //  child: Center( child: Text(widget.peg.index.toString()), ),
        decoration: containerDecoration,
      ),
    );
  }
}

extension ColorUtils on Color {
  Color mix(Color another, double amount) {
    return Color.lerp(this, another, amount) ?? another;
  }
}
