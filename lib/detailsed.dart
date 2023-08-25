import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  Map m;
  DetailsPage({Key? key, required this.m}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details of cliked item"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.m['title'].toString()),
          SizedBox(
            height: 10,
          ),
          Text(widget.m['body'])
        ],
      ),
    );
  }
}
