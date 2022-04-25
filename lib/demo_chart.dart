import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class DemoSeries {
  final int x;
  final int y;

  DemoSeries(this.x, this.y);
}

class DemoChart extends StatelessWidget {
  final List<int> data;
  
  const DemoChart({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<DemoSeries> demoData = [];
    data.asMap().forEach((key, value) {
      demoData.add(DemoSeries(key, value));
    });

    final List<charts.Series<DemoSeries, int>> series = [
      charts.Series(
        id: 'DemoData',
        data: demoData,
        domainFn: (DemoSeries series, _) => series.x,
        measureFn: (DemoSeries series, _) => series.y,
      )
    ];

    return charts.LineChart(
      series,
      animate: false,
    );
  }

}