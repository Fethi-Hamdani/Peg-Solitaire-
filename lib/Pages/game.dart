import 'package:flutter/material.dart';
import 'package:pegsolitaire/Models/board_settings.dart';
import 'package:pegsolitaire/Models/peg.dart';
import 'package:pegsolitaire/ViewModels/board.dart';
import 'package:provider/provider.dart';

double pegSize = 40;

class Game1 extends StatefulWidget {
  const Game1({Key? key}) : super(key: key);

  @override
  _Game1State createState() => _Game1State();
}

class _Game1State extends State<Game1> {
  BoardSettings normalSettings = BoardSettings(
      size: 7,
      empty: [25],
      blank: [1, 2, 8, 9, 6, 7, 13, 14, 36, 37, 43, 44, 41, 42, 48, 49]);

  BoardSettings miniSettings = BoardSettings(size: 4, blank: [], empty: [13]);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => Board(settings: miniSettings),
        builder: (context, child) {
          return Scaffold(
              appBar: AppBar(),
              backgroundColor: Colors.grey,
              body: Consumer<Board>(builder: (context, board, child) {
                return Center(
                  child: Column(
                    children: [
                      Container(
                        color:
                            board.gameEnded ? Colors.redAccent : Colors.green,
                        height: MediaQuery.of(context).size.height * 0.2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("Remaining Pegs " +
                                board.fullPegsCount.toString() +
                                "/" +
                                board.totallPegs.toString()),
                            Text("gameEnded : ${board.gameEnded}"),
                          ],
                        ),
                      ),
                      Container(
                        width: board.settings.size * (pegSize + 10),
                        height: board.settings.size * (pegSize + 10),
                        // padding: EdgeInsets.all(20),
                        color: Colors.grey,
                        child: GridView.count(
                          childAspectRatio: 1,
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          crossAxisCount: board.settings.size,
                          children: List.generate(board.itemsCount, (index) {
                            return Center(
                              child: PegView(
                                  onclick: () {
                                    board.pegClicked(index + 1);
                                  },
                                  peg: board.pegAtIndex(index + 1)),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                );
              }));
        });
  }
}

class PegView extends StatefulWidget {
  final Peg peg;
  final Function() onclick;
  const PegView({required this.onclick, required this.peg, Key? key})
      : super(key: key);

  @override
  _PegViewState createState() => _PegViewState();
}

class _PegViewState extends State<PegView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onclick,
      child: Container(
        height: pegSize,
        width: pegSize,
        child: Center(
          child: Text(widget.peg.index.toString()),
        ),
        decoration: BoxDecoration(
            color: widget.peg.color, borderRadius: BorderRadius.circular(360)),
      ),
    );
  }
}
