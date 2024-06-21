import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
class ColumnChartExample extends StatefulWidget {
  const ColumnChartExample({super.key});

  @override
  State<ColumnChartExample> createState() => _ColumnChartExampleState();
}

class _ColumnChartExampleState extends State<ColumnChartExample> {
  final List<ChartData> _example = [
    ChartData('Ind', 20, 40, 50, 12),
    ChartData('Eng', 10, 35, 30, 12),
    ChartData('USA', 30, 31, 43, 16),
    ChartData('Uk', 42, 21, 22, 11),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SfCartesianChart(
          primaryXAxis: CategoryAxis(),
          series:<ChartSeries> [
            StackedColumnSeries<ChartData,String>(
              dataSource: _example,
              xValueMapper: (ChartData data,_) => data.x,
              yValueMapper: (ChartData data,_) => data.y1,
            ),
            StackedColumnSeries<ChartData,String>(
              dataSource: _example,
              xValueMapper: (ChartData data,_) => data.x,
              yValueMapper: (ChartData data,_) => data.y1,
            ),
            StackedColumnSeries<ChartData,String>(
              dataSource: _example,
              xValueMapper: (ChartData data,_) => data.x,
              yValueMapper: (ChartData data,_) => data.y1,
            ),
          ],
        ),
      ),
    );
  }
}
class ChartData{
  final String x;
  final double y1;
  final double y2;
  final double y3;
  final double y4;
  ChartData(this.x,this.y1,this.y2,this.y3,this.y4);
}
