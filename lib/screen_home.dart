import 'package:cg_proto/screen_site.dart';
import 'package:cg_proto/test_data.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CG Proto',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeWidget(title: 'Home'),
    );
  }
}

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: siteList.length,
        itemBuilder: (context, index) {
          return InkWell(
            child: Container(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                siteList[index],
                style: const TextStyle(
                  fontSize: 18.0
                ),
              ),
            ),
            onTap: () {
              // TODO: What happens when we click this site
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SiteWidget(title: siteList[index])),
              );
            },
          );
        },
      ),
    );
  }
}