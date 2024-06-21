import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
class BarChartExample extends StatefulWidget {
  const BarChartExample({super.key});

  @override
  State<BarChartExample> createState() => _BarChartExampleState();
}

class _BarChartExampleState extends State<BarChartExample> {
  final List<Climate> _chartData = [
    Climate('Sun', 20),
    Climate('Mon', 31),
    Climate('Tues', 34),
    Climate('Weds', 28),
    Climate('Thurs', 34),
    Climate('Fri', 32),
    Climate('Sat', 23),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SfCartesianChart(
        series: <ChartSeries>[
          BarSeries<Climate,String>(
              dataSource: _chartData,
              xValueMapper: (Climate data,_) =>data.days,
              yValueMapper: (Climate data,_) =>data.temperature,
          )
        ],
        primaryXAxis: CategoryAxis(),
      ),
    );
  }
}

class Climate {
  final String days;
  final double temperature;
  Climate(this.days, this.temperature);
}
