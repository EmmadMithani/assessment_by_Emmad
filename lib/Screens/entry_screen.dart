import 'package:assessment_by_emmad/Widgets/entry_form.dart';
import 'package:flutter/material.dart';

class EntryScreen extends StatelessWidget {
  static const String routeName='./EntryScreen';
  final _titleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add here'),
        elevation: 06,
      ),
      backgroundColor: Colors.grey[100],
      body: EntryForm(),
    );
  }
}
