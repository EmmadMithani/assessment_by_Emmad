import 'package:assessment_by_emmad/Screens/entry_screen.dart';
import 'package:assessment_by_emmad/Screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Model/Provider/entry.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Entry()),
      ],
      child: MaterialApp(
        title: 'Emmad',
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (ctx) => HomeScreen(),
          HomeScreen.routeName: (ctx) => HomeScreen(),
          EntryScreen.routeName: (ctx) => EntryScreen()
        },
      ),
    );
  }
}
