import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Pages/home.dart';
import 'ViewModels/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => AppTheme(),
        builder: (context, child) {
          return MaterialApp(
            title: 'Peg Solitaire',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: const Home(),
          );
        });
  }
}
