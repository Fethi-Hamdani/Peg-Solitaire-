import 'package:flutter/material.dart';
import 'package:pegsolitaire/Models/board_settings.dart';
import 'package:pegsolitaire/ViewModels/board.dart';
import 'package:pegsolitaire/Widgets/peg.dart';
import 'package:provider/provider.dart';

class Game1 extends StatefulWidget {
  const Game1({Key? key}) : super(key: key);

  @override
  _Game1State createState() => _Game1State();
}

class _Game1State extends State<Game1> {
  double pegSize = 40;
  BoardSettings normalSettings = BoardSettings(
      size: 7,
      empty: [25],
      blank: [1, 2, 8, 9, 6, 7, 13, 14, 36, 37, 43, 44, 41, 42, 48, 49]);

  BoardSettings miniSettings = BoardSettings(size: 4, blank: [], empty: [13]);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => Board(settings: normalSettings),
        builder: (context, child) {
          return Scaffold(
              backgroundColor: Colors.grey,
              body: Consumer<Board>(builder: (context, board, child) {
                return Center(
                  //key: UniqueKey(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
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
                                  key: Key("${index + 1}"),
                                  pegSize: pegSize,
                                  peg: board.pegAtIndex(index + 1)),
                            );
                          }),
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Center(
                              child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        board.resetGame();
                                      },
                                      child: Text("Reset Game"))),
                            ),
                            Center(
                              child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        board.undoMove();
                                      },
                                      child: Text("Undo ${board.moves}"))),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }));
        });
  }
}
