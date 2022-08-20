import 'package:assessment_by_emmad/Model/Provider/entry.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:pie_chart/pie_chart.dart';

class SalaryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<EntryItem> data = Provider.of<Entry>(context, listen: true).items;
    double expenseData = Provider.of<Entry>(context, listen: true).getTotalExpense();
    double incomeData = Provider.of<Entry>(context, listen: true).getTotalIncome();

    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        PieChart(
          dataMap: {
            "Expense": expenseData,
            "Income": incomeData,
          },
          animationDuration: const Duration(milliseconds: 800),
          chartLegendSpacing: 32,
          chartRadius: MediaQuery.of(context).size.width / 3.9,
          initialAngleInDegree: 0,
          chartType: ChartType.ring,
          ringStrokeWidth: 28,
          colorList: [Colors.red, Colors.green],
          legendOptions: const LegendOptions(
            showLegendsInRow: false,
            legendPosition: LegendPosition.right,
            showLegends: true,
            legendTextStyle: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          chartValuesOptions: const ChartValuesOptions(
            showChartValueBackground: true,
            showChartValues: true,
            showChartValuesInPercentage: false,
            showChartValuesOutside: false,
            decimalPlaces: 1,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: data.length,
            itemBuilder: (ctx, index) => Card(
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 15,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(30)),
                    padding: const EdgeInsets.all(10),
                    child: Icon(
                      data[index].expense == "Expense"
                          ? Icons.arrow_back_rounded
                          : Icons.arrow_forward_rounded,
                      color: data[index].expense == "Expense"
                          ? Colors.red
                          : Colors.green,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data[index].title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        data[index].description,
                        style: Theme.of(context).textTheme.caption,
                      ),
                      Text(
                        '${data[index].date} at ${data[index].time}',
                        style:
                            const TextStyle(fontSize: 11, color: Colors.grey),
                      )
                    ],
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      data[index].amount.toString(),
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
