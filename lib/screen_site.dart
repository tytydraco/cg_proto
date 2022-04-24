import 'package:cg_proto/demo_chart.dart';
import 'package:flutter/material.dart';

class SiteWidget extends StatefulWidget {
  const SiteWidget({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<SiteWidget> createState() => _SiteWidgetState();
}

class DataBox extends StatelessWidget {
  final String text;

  const DataBox({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.0,
      width: 48.0,
      margin: const EdgeInsets.all(12.0),
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        color: Colors.blue
      ),
    );
  }
}

class ChartBox extends StatelessWidget {
  final String title;

  const ChartBox({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Text(title),
          const SizedBox(
            height: 100.0,
            child: DemoChart(),
          ),
        ],
      ),
    );
  }

}

class _SiteWidgetState extends State<SiteWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: [
          Row(
            children: const [
              DataBox(text: 'T'),
              DataBox(text: 'WS'),
              DataBox(text: 'WD'),
              DataBox(text: 'SM'),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          const ChartBox(title: 'Temperature'),
          const ChartBox(title: 'Moisture'),
          const ChartBox(title: 'Wind Speed'),
          const ChartBox(title: 'Humidity'),
          const ChartBox(title: 'Etc...'),
        ],
      ),
    );
  }
}
