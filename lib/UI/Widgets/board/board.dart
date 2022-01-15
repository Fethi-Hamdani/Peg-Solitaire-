import 'package:flutter/material.dart';
import 'package:pegsolitaire/UI/Widgets/peg.dart';
import 'package:pegsolitaire/ViewModels/casual_game.dart';
import 'package:provider/provider.dart';

class PegBoard extends StatefulWidget {
  final double pegSize;
  const PegBoard({
    Key? key,
    required this.pegSize,
  }) : super(key: key);

  @override
  _PegBoardState createState() => _PegBoardState();
}

class _PegBoardState extends State<PegBoard> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CasualGame>(builder: (context, game, child) {
      return GridView.count(
        childAspectRatio: 1,
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        crossAxisCount: game.settings.size,
        children: List.generate(game.board.itemsCount, (index) {
          return Center(
            child: PegView(
                onClick: () {
                  return game.pegClicked((index + 1));
                },
                key: Key("${index + 1}"),
                pegSize: widget.pegSize,
                peg: game.board.pegAtIndex(index + 1)),
          );
        }),
      );
    });
  }
}
