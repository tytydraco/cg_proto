import 'dart:math';

import 'package:cg_proto/data_chart.dart';
import 'package:cg_proto/screen_settings.dart';
import 'package:flutter/material.dart';

class SiteWidget extends StatefulWidget {
  const SiteWidget({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<SiteWidget> createState() => _SiteWidgetState();
}

class DataBox extends StatelessWidget {
  final String text;
  final String label;

  const DataBox({Key? key, required this.text, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
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
              borderRadius: BorderRadius.circular(12.0),
              color: Colors.blue
          ),
        ),
        SizedBox(
          width: 64.0,
          child: Center(
            child: Text(
              label,
              textAlign: TextAlign.center,
            ),
          ),
        )
      ]
    );
  }
}

class ChartBox extends StatelessWidget {
  final String title;
  final List<int> data;

  const ChartBox({Key? key, required this.title, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Text(title),
          SizedBox(
            height: 100.0,
            child: DataChart(
              data: data
            ),
          ),
        ],
      ),
    );
  }

}

class _SiteWidgetState extends State<SiteWidget> {
  List<int> randomData(int n) {
    Random r = Random();
    return List.generate(n, (index) => r.nextInt(11));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsWidget(title: widget.title)),
              );
            },
            icon: const Icon(Icons.settings)
          )
        ],
      ),
      body: ListView(
        children: [
          Row(
            children: const [
              DataBox(text: '45', label: 'Temperature'),
              DataBox(text: '55', label: 'Wind Speed'),
              DataBox(text: '78', label: 'Wind Direction'),
              DataBox(text: '13', label: 'Soil Moisture'),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          ChartBox(title: 'Temperature', data: randomData(7)),
          ChartBox(title: 'Moisture', data: randomData(7)),
          ChartBox(title: 'Wind Speed', data: randomData(7)),
          ChartBox(title: 'Humidity', data: randomData(7)),
          ChartBox(title: 'Etc...', data: randomData(7)),
        ],
      ),
    );
  }
}
