import 'dart:convert';

import 'package:digital_ordering/constants.dart';
import 'package:digital_ordering/layouts/ad_compliant_reply_post.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Adcomplaintview extends StatefulWidget {
  const Adcomplaintview({Key? key}) : super(key: key);

  @override
  _AdcomplaintviewState createState() => _AdcomplaintviewState();

  // static var cid;
}

class _AdcomplaintviewState extends State<Adcomplaintview> {
  late List data;
  void List_function() async {
    var url = Uri.parse("$nodeURL/a_view_comp/");
    Response resp1 = await post(url, body: {"uid": "1"});

    data = jsonDecode(resp1.body);
    this.setState(() {});
    print(resp1.body);
    print(data);
  }

  @override
  Widget build(BuildContext context) {
    List_function();
    return Scaffold(
      appBar: AppBar(
        title: Text('Complaint Box'),
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
                            // new Text(data[index]["comp"].toUpperCase(),style: Theme.of(context).textTheme.title,
                            // ),
                            new SizedBox(height: 10.0),
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                new Text(
                                  "Complaint : " +
                                      data[index]["comp"].toString(),
                                  style: new TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                              ],
                            ),
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                new Text(
                                  "User : " + data[index]["unm"].toString(),
                                  style: new TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                                new Text("Date : " + data[index]["date"],
                                    style: new TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17)),
                              ],
                            ),
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                ElevatedButton.icon(
                                  onPressed: () {
                                    // Respond to button press
                                    var cid = data[index]["id"];
                                    Adcomplntreply.cid = cid;
                                    print(cid);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => Adcomplntreply()));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.green,
                                  ),
                                  icon: Icon(Icons.label_important, size: 26),
                                  label: Text("Reply"),
                                ),
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
