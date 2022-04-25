import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class SettingsWidget extends StatefulWidget {
  const SettingsWidget({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<SettingsWidget> createState() => _SettingsWidgetState();
}

class VisibilityCheckBox extends StatefulWidget {
  final String chartTitle;

  const VisibilityCheckBox({Key? key, required this.chartTitle}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _StatefulWidgetState();
}

class _StatefulWidgetState extends State<VisibilityCheckBox> {
  bool value = false;

  Future<bool> currentState() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(widget.chartTitle.toLowerCase()) ?? true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        initialData: value,
        future: currentState(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return CheckboxListTile(
              title: Text(widget.chartTitle),
              value: snapshot.data as bool? ?? false,
              onChanged: (state) async {
                final prefs = await SharedPreferences.getInstance();
                prefs.setBool(widget.chartTitle.toLowerCase(), state ?? false);

                setState(() {
                  value = state ?? false;
                });
              }
            );
          }
        }
    );
  }
}

class _SettingsWidgetState extends State<SettingsWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings: ${widget.title}"),
      ),
      body: ListView(
        children: const [
          VisibilityCheckBox(chartTitle: 'Temperature'),
          VisibilityCheckBox(chartTitle: 'Moisture'),
          VisibilityCheckBox(chartTitle: 'Wind Speed'),
          VisibilityCheckBox(chartTitle: 'Humidity'),
          VisibilityCheckBox(chartTitle: 'Etc...'),
        ],
      ),
    );
  }
}