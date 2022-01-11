import 'package:flutter/material.dart';
import 'package:pegsolitaire/Models/peg.dart';
import 'package:pegsolitaire/ViewModels/board.dart';
import 'package:pegsolitaire/ViewModels/peg_controller.dart';
import 'package:provider/provider.dart';

class PegView extends StatelessWidget {
  final Peg peg;
  final double pegSize;
  const PegView({
    Key? key,
    required this.peg,
    required this.pegSize,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PegController>(
        create: (context) => PegController(peg: peg, pegSize: pegSize),
        builder: (context, child) {
          return Consumer<PegController>(builder: (context, peg, child) {
            return peg.peg.state == PegState.blank
                ? SizedBox()
                : GestureDetector(
                    onTap: () {
                      peg.changePegState =
                          Provider.of<Board>(context, listen: false)
                              .pegClicked(peg.peg.index);
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      curve: Curves.easeInOutSine,
                      height: peg.pegSize,
                      width: peg.pegSize,
                      alignment: Alignment.center,

                      child: AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          curve: Curves.easeInOutSine,
                          height: 15,
                          width: 15,
                          decoration: BoxDecoration(
                              color: peg.peg.state == PegState.possible
                                  ? peg.color
                                  : null,
                              borderRadius: BorderRadius.circular(360))),
                      //  child: Center( child: Text(widget.peg.index.toString()), ),
                      decoration: BoxDecoration(
                          color: peg.peg.state == PegState.empty ||
                                  peg.peg.state == PegState.possible
                              ? Colors.white24
                              : peg.color,
                          border: peg.peg.state == PegState.empty ||
                                  peg.peg.state == PegState.possible
                              ? Border.all(color: Colors.white, width: 2)
                              : null,
                          borderRadius: BorderRadius.circular(360)),
                    ),
                  );
          });
        });
  }
}
