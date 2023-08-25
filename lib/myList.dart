import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myproj/detailsed.dart';

class MyList extends StatefulWidget {
  const MyList({Key? key}) : super(key: key);

  @override
  _MyListState createState() => _MyListState();
}

class _MyListState extends State<MyList> {
  List data = [];

  List details = [];
  Future<void> getList() async {
    var response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/posts'),
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      setState(() {
        data.clear();
        data.addAll(jsonDecode(response.body));
      });
    }
  }

  Future<Map> getDetails(String id) async {
    var response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/posts/$id'),
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return {};
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My list'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: data
              .map((e) => InkWell(
                    onTap: () {
                      getDetails(e['id'].toString()).then((value) {
                        // showDialog(
                        //     context: context,
                        //     builder: (context) => AlertDialog(
                        //           title: Text(value['title'].toString()),
                        //           content: Text(value['body'].toString()),
                        //         ));
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailsPage(
                                      m: e,
                                    )));
                      });
                    },
                    child: Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(e['title'].toString()),
                          SizedBox(
                            height: 10,
                          ),
                          Text(e['body'])
                        ],
                      ),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
