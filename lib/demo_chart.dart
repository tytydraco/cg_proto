import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class DemoSeries {
  final int x;
  final int y;

  DemoSeries(this.x, this.y);
}

class DemoChart extends StatelessWidget {
  const DemoChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<DemoSeries> demoData = [
      DemoSeries(0, 5),
      DemoSeries(1, 4),
      DemoSeries(2, 7),
      DemoSeries(3, 3),
      DemoSeries(4, 4),
      DemoSeries(5, 2),
      DemoSeries(6, 3),
    ];

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