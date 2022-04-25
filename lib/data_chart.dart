import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class XYSeries {
  final int x;
  final int y;

  XYSeries(this.x, this.y);
}

class DataChart extends StatelessWidget {
  final List<int> data;
  
  const DataChart({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<XYSeries> demoData = [];
    data.asMap().forEach((key, value) {
      demoData.add(XYSeries(key, value));
    });

    final List<charts.Series<XYSeries, int>> series = [
      charts.Series(
        id: 'DemoData',
        data: demoData,
        domainFn: (XYSeries series, _) => series.x,
        measureFn: (XYSeries series, _) => series.y,
      )
    ];

    return charts.LineChart(
      series,
      animate: false,
    );
  }
}