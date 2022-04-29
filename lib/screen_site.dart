import 'dart:math';

import 'package:cg_proto/data_chart.dart';
import 'package:cg_proto/repo.dart';
import 'package:cg_proto/screen_camera.dart';
import 'package:cg_proto/screen_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  final String prefKey;

  const ChartBox({Key? key, required this.title, required this.prefKey}) : super(key: key);

  Future<bool> currentState() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(prefKey) ?? true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: currentState(),
      initialData: false,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          bool showing = snapshot.data as bool? ?? false;
          return Visibility(
            visible: showing,
            child: Container(
              margin: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Text(title),
                  SizedBox(
                    height: 100.0,
                    child: FutureBuilder(
                      future: Repo.getSiteData("site", title),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return DataChart(
                            data: snapshot.data as List<int>
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}

class _SiteWidgetState extends State<SiteWidget> {
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
              ).then((_) {
                setState(() {});
              });
            },
            icon: const Icon(Icons.settings)
          ),
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CameraWidget(title: widget.title)),
                );
              },
              icon: const Icon(Icons.camera_alt)
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
          ChartBox(title: 'Temperature', prefKey: "${widget.title}_temperature"),
          ChartBox(title: 'Moisture', prefKey: "${widget.title}_moisture"),
          ChartBox(title: 'Wind Speed', prefKey: "${widget.title}_wind_speed"),
          ChartBox(title: 'Humidity', prefKey: "${widget.title}_humidity"),
          ChartBox(title: 'Etc...', prefKey: "${widget.title}_etc"),
        ],
      ),
    );
  }
}
