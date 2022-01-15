import 'package:flutter/material.dart';
import 'package:pegsolitaire/ViewModels/theme.dart';
import 'package:provider/provider.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Consumer<AppTheme>(
              builder: (context, value, child) => GestureDetector(
                    onTap: () {
                      value.darkModeChaneged();
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            RichText(
                                text: TextSpan(text: 'Dark Mode\n', children: [
                              TextSpan(
                                text: value.darkMode ? 'Active' : 'Inactive',
                              )
                            ])),
                            AnimatedContainer(
                              width: 44,
                              height: 24,
                              duration: const Duration(milliseconds: 200),
                              padding: const EdgeInsets.all(2),
                              curve: Curves.ease,
                              alignment: value.darkMode
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: Container(
                                height: 20,
                                width: 20,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle),
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(360),
                                  color: value.darkMode
                                      ? Colors.blue
                                      : Colors.blueGrey),
                            ),
                          ]),
                    ),
                  )),
        ],
      ),
    );
  }
}
