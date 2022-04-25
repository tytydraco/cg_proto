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
  final String prefKey;

  const VisibilityCheckBox({Key? key, required this.chartTitle, required this.prefKey}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _VisibilityCheckBoxState();
}

class _VisibilityCheckBoxState extends State<VisibilityCheckBox> {
  bool value = false;

  Future<bool> currentState() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(widget.prefKey) ?? true;
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
                prefs.setBool(widget.prefKey, state ?? false);

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
        children: [
          VisibilityCheckBox(chartTitle: 'Temperature', prefKey: "${widget.title}_temperature"),
          VisibilityCheckBox(chartTitle: 'Moisture', prefKey: "${widget.title}_moisture"),
          VisibilityCheckBox(chartTitle: 'Wind Speed', prefKey: "${widget.title}_wind_speed"),
          VisibilityCheckBox(chartTitle: 'Humidity', prefKey: "${widget.title}_humidity"),
          VisibilityCheckBox(chartTitle: 'Etc...', prefKey: "${widget.title}_etc"),
        ],
      ),
    );
  }
}