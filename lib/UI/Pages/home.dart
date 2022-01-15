import 'package:flutter/material.dart';
import 'package:pegsolitaire/UI/Pages/game.dart';
import 'package:pegsolitaire/UI/Pages/settings.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Game1()));
                    },
                    child: Text("Play"))),
          ),
          Center(
            child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: ElevatedButton(onPressed: () {}, child: Text("Stages"))),
          ),
          Center(
            child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child:
                    ElevatedButton(onPressed: () {}, child: Text("Records"))),
          ),
          Center(
            child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Settings()));
                    },
                    child: Text("Settings"))),
          ),
        ],
      ),
    );
  }
}
