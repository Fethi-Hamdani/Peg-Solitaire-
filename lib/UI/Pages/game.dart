import 'package:flutter/material.dart';
import 'package:pegsolitaire/Core/Models/board_settings.dart';
import 'package:pegsolitaire/UI/Widgets/board/board.dart';
import 'package:pegsolitaire/UI/Widgets/stopwatch.dart';
import 'package:pegsolitaire/ViewModels/casual_game.dart';
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
        create: (context) => CasualGame(settings: normalSettings),
        builder: (context, child) {
          return Scaffold(
              backgroundColor: Colors.grey,
              body: Consumer<CasualGame>(builder: (context, game, child) {
                return Center(
                  //key: UniqueKey(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("Remaining Pegs " +
                                game.board.fullPegs.length.toString() +
                                "/" +
                                game.board.totallPegs.toString()),
                            Text("gameEnded : ${game.board.gameEnded}"),
                          ],
                        ),
                      ),
                      Container(
                          alignment: Alignment.center,
                          height: MediaQuery.of(context).size.height * 0.1,
                          child: StopwatchTimer(
                            stopwatch: game.timer,
                          )),
                      Expanded(
                        child: Center(
                          child: Container(
                            width: game.settings.size * (pegSize + 10),
                            height: game.settings.size * (pegSize + 10),
                            // padding: EdgeInsets.all(20),
                            color: Colors.grey,
                            child: PegBoard(
                              pegSize: pegSize,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Center(
                              child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        game.resetGame();
                                      },
                                      child: Text("Reset Game"))),
                            ),
                            Center(
                              child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        game.undoMove();
                                      },
                                      child: Text(
                                          "Undo ${game.movesMade}"))),
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
