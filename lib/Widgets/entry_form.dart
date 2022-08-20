import 'package:assessment_by_emmad/Model/Provider/entry.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EntryForm extends StatefulWidget {
  @override
  State<EntryForm> createState() => _EntryFormState();
}

class _EntryFormState extends State<EntryForm> {
  String amount = '';
  String dropDownValue = 'Expense';
  final _amountController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  final _descriptionFocusNode = FocusNode();
  final _dateFocusNode = FocusNode();
  final _timeFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();

  var _newEntry = EntryItem(
      id: "",
      title: "",
      description: "",
      date: DateTime.now().toIso8601String(),
      time: DateTime.now().toIso8601String(),
      expense: "",
      amount: 0.0);

  @override
  void dispose() {
    _descriptionFocusNode.dispose();
    _dateFocusNode.dispose();
    _timeFocusNode.dispose();
    super.dispose();
  }

  void _saveForm() {

    _addExpense(dropDownValue);

    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    Provider.of<Entry>(context, listen: false).addNewEntry(_newEntry);
    Navigator.of(context).pop();
  }

  _addExpense(String value) => _newEntry = EntryItem(
      id: _newEntry.id,
      title: _newEntry.title,
      description: _newEntry.description,
      date: _newEntry.date,
      time: _newEntry.time,
      expense: value,
      amount: _newEntry.amount);

  @override
  Widget build(BuildContext context) {
    final format = DateFormat('hh:mm a');
    return Form(
      key: _form,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              flex: 2,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.yellow[50],
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                        ),
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_descriptionFocusNode);
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: 'Title',
                          ),
                          onSaved: (value) {
                            _newEntry = EntryItem(
                                id: _newEntry.id,
                                title: value.toString(),
                                description: _newEntry.description,
                                date: _newEntry.date,
                                time: _newEntry.time,
                                expense: _newEntry.expense,
                                amount: _newEntry.amount);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please provide a value.';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.yellow[50],
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                        ),
                        child: TextFormField(
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).requestFocus(_dateFocusNode);
                          },
                          focusNode: _descriptionFocusNode,
                          minLines: 2,
                          maxLines: 5,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                10,
                              ),
                            ),
                            labelText: 'Description',
                          ),
                          onSaved: (value) {
                            _newEntry = EntryItem(
                                id: _newEntry.id,
                                title: _newEntry.title,
                                description: value.toString(),
                                date: _newEntry.date,
                                time: _newEntry.time,
                                expense: _newEntry.expense,
                                amount: _newEntry.amount);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a description.';
                            }
                            if (value.length <= 10) {
                              return 'Should be at least 10 characters long.';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2022),
                                  lastDate: DateTime.now());

                              if (pickedDate != null) {
                                setState(() {
                                  _dateController.text = DateFormat.yMd().format(pickedDate).toString();
                                });
                              }
                            },
                            child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                    color: Colors.yellow[50],
                                    border: Border.all(color: Colors.black54)),
                                child: const Icon(Icons.date_range)),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.yellow[50],
                                borderRadius: BorderRadius.circular(
                                  10,
                                ),
                              ),
                              child: TextFormField(
                                onFieldSubmitted: (_) {
                                  FocusScope.of(context)
                                      .requestFocus(_timeFocusNode);
                                },
                                controller: _dateController,
                                focusNode: _dateFocusNode,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  labelText: 'Date',
                                ),
                                onSaved: (value) {
                                  _newEntry = EntryItem(
                                      id: _newEntry.id,
                                      title: _newEntry.title,
                                      description: _newEntry.description,
                                      date: value.toString().substring(0,9),
                                      time: _newEntry.time,
                                      expense: _newEntry.expense,
                                      amount: _newEntry.amount);
                                },
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2022),
                                      lastDate: DateTime.now());

                                  if (pickedDate != null) {
                                    setState(() {
                                      _dateController.text =
                                          DateFormat.yMd().format(pickedDate).toString();
                                    });
                                  }
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Pickup the date please.';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: Colors.yellow[50],
                                  border: Border.all(color: Colors.black54)),
                              child: const Icon(CupertinoIcons.clock)),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.yellow[50],
                                borderRadius: BorderRadius.circular(
                                  10,
                                ),
                              ),
                              child: DateTimeField(
                                format: format,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  labelText: 'Time',
                                ),
                                onShowPicker: (_, currentValue) async {
                                  final time = await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.fromDateTime(
                                          currentValue ?? DateTime.now()));
                                  return DateTimeField.convert(time);
                                },
                                onSaved: (value) {
                                  _newEntry = EntryItem(
                                      id: _newEntry.id,
                                      title: _newEntry.title,
                                      description: _newEntry.description,
                                      date: _newEntry.date,
                                      time: format.format(value!).toString(),
                                      expense: _newEntry.expense,
                                      amount: _newEntry.amount);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.yellow[50],
                                  border:
                                      Border.all(width: 1, color: Colors.grey),
                                  borderRadius: BorderRadius.circular(
                                    10,
                                  ),
                                ),
                                child: DropdownButton(
                                  style: const TextStyle(
                                    color: Colors.grey,
                                  ),
                                  underline: const SizedBox.shrink(),
                                  isExpanded: true,
                                  value: dropDownValue,
                                  items: ['Expense', 'Income']
                                      .map(
                                        (e) => DropdownMenuItem(
                                          value: e,
                                          child: Text(e),
                                        ),
                                      )
                                      .toList(),
                                  onChanged: (dynamic value) {
                                    setState(() {
                                      dropDownValue = value;
                                    });
                                  },
                                )),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.yellow[50],
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                        ),
                        child: TextFormField(
                          textInputAction: TextInputAction.done,
                          controller: _amountController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: 'Amount',
                            enabled: false,
                          ),
                          onFieldSubmitted: (_) {
                            _saveForm();
                          },
                          onSaved: (value) {
                            _newEntry = EntryItem(
                                id: _newEntry.id,
                                title: _newEntry.title,
                                description: _newEntry.description,
                                date: _newEntry.date,
                                time: _newEntry.time,
                                expense: _newEntry.expense,
                                amount: double.parse(value!));
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please provide an amount.';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 237,
                        width: 350,
                        child: GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    childAspectRatio: 1.6,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10),
                            itemCount: 9,
                            itemBuilder: (context, index) {
                              String currentIndex = (++index).toString();
                              return numberButton(currentIndex, () {
                                amount += currentIndex;
                                setState(() {
                                  _amountController.text = amount;
                                });
                              });
                            }),
                      ),
                      SizedBox(
                        width: 350,
                        child: Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: numberButton(("0").toString(), () {
                                  amount += "0";
                                  setState(() {
                                    _amountController.text = amount;
                                  });
                                })),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                                flex: 2,
                                child: numberButton("Delete", () {
                                  amount = amount.replaceRange(
                                      amount.length - 1, amount.length, "");
                                  setState(() {
                                    _amountController.text = amount;
                                  });
                                }, color: Colors.red))
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 54),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(30)),
                                child: FittedBox(
                                  child: IconButton(
                                    iconSize: 35,
                                    onPressed: _saveForm,
                                    icon: const Icon(Icons.done),
                                  ),
                                )),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }

  Widget numberButton(String number, GestureTapCallback callback,
      {Color color = Colors.blueGrey}) {
    return SizedBox(
      height: 80,
      width: 30,
      child: MaterialButton(
        shape: const StadiumBorder(),
        color: color,
        child: Text(number),
        onPressed: callback,
      ),
    );
  }
}
