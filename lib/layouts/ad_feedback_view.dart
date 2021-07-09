import 'dart:convert';

import 'package:digital_ordering/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Ad_feedback extends StatefulWidget {
  const Ad_feedback({Key? key}) : super(key: key);

  @override
  _Ad_feedbackState createState() => _Ad_feedbackState();
}

class _Ad_feedbackState extends State<Ad_feedback> {
  late List data;

  void List_function() async {
    var url = Uri.parse("$nodeURL/a_view_feedback/");
    Response resp1 = await post(url);
    print(resp1.body);
    data = jsonDecode(resp1.body);
    this.setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List_function();
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback'),
      ),
      backgroundColor: Colors.grey,
      body: Container(
        child: new ListView.builder(
          itemCount: data == null ? 0 : data.length,
          itemBuilder: (context, index) {
            return new Padding(
              padding: new EdgeInsets.fromLTRB(20, 05, 10, 10),
              child: new Card(
                elevation: 2.0,
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(16.0)),
                child: InkWell(
                  onTap: () {
                    print("tapped");
                    //  tap funtion here
                  },
                  child: new Column(
                    children: <Widget>[
                      new Padding(
                        padding: new EdgeInsets.all(16.0),
                        child: new Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            new Text(
                              data[index]["feedback"].toUpperCase(),
                              style: Theme.of(context).textTheme.title,
                            ),
                            new SizedBox(height: 10.0),
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                new Text(
                                    "User : " + data[index]["user"].toString(),
                                    style: new TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)),
                                new Text("Date : " + data[index]["date"],
                                    style: new TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
