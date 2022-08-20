import 'package:assessment_by_emmad/Screens/entry_screen.dart';
import 'package:assessment_by_emmad/Widgets/salary_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Model/Provider/entry.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = './HomeScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Salaries'),
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<Entry>(context, listen: false).clearAll();
            },
            icon: const Icon(Icons.delete_forever),
          ),
        ],
        elevation: 08,
      ),
      body: SalaryList(),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed(EntryScreen.routeName);
          },
          child: const Icon(Icons.add)),
    );
  }
}
