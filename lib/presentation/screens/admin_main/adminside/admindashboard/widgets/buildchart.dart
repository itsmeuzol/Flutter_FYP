import 'package:finalyear/presentation/screens/admin_main/adminside/admindashboard/ui/admindashboard.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

Widget buildChart() {
  return SizedBox(
    child: SfCartesianChart(
      title: const ChartTitle(
          text: 'Dustbin Overview',
          textStyle:
              TextStyle(color: Color(0xFF365307), fontWeight: FontWeight.bold)),
      primaryXAxis: const CategoryAxis(),
      primaryYAxis: const NumericAxis(minimum: 0, maximum: 100, interval: 10),
      series: <CartesianSeries>[
        // Explicit casting
        ColumnSeries<DustbinData, String>(
          dataSource: getColumnData(),
          xValueMapper: (DustbinData dustbin, _) => dustbin.year,
          yValueMapper: (DustbinData dustbin, _) => dustbin.y,
          color: Colors.green,
        ),
        ColumnSeries<DustbinData, String>(
          dataSource: getColumnData(),
          xValueMapper: (DustbinData dustbin, _) => dustbin.year,
          yValueMapper: (DustbinData dustbin, _) => dustbin.y1,
          color: (Colors.yellow),
        ),
        ColumnSeries<DustbinData, String>(
          dataSource: getColumnData(),
          xValueMapper: (DustbinData dustbin, _) => dustbin.year,
          yValueMapper: (DustbinData dustbin, _) => dustbin.y2,
          color: Colors.red,
        )
      ],
    ),
  );
}
