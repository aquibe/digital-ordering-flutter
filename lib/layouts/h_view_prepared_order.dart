import 'dart:convert';

import 'package:digital_ordering/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Assign_or extends StatefulWidget {
  const Assign_or({Key? key}) : super(key: key);

  @override
  _Assign_orState createState() => _Assign_orState();

  static var oid;
}

class _Assign_orState extends State<Assign_or> {
  late List data;

  void List_function() async {
    var url = Uri.parse("$nodeURL/h_order22/");
    Response resp1 = await post(url, body: {"fid": "prepared"});
    print(resp1.body);
    data = jsonDecode(resp1.body);

    this.setState(() {});
  }

  void update() async {
    var url = Uri.parse("$nodeURL/update_order22/");
    var mid = (Assign_or.oid).toString();
    Response resp = await post(url, body: {"oid": mid});
    print(resp.body);

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Status Updated...")));
    List_function();
  }

  @override
  Widget build(BuildContext context) {
    List_function();
    return Scaffold(
      appBar: AppBar(
        title: Text('Approved Order'),
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
                      new ClipRRect(
                          child: new Image.network(
                            "https://aquibe.github.io/image-host/${data[index]['type']}.jpg",
                            fit: BoxFit.fill,
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: new Radius.circular(16.0),
                            topRight: new Radius.circular(16.0),
                          )),
                      new Padding(
                        padding: new EdgeInsets.all(16.0),
                        child: new Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            new Text(
                              (data[index]["food"]).toUpperCase(),
                              style: Theme.of(context).textTheme.title,
                            ),
                            new SizedBox(height: 10.0),
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                new Text(
                                    "User : " + data[index]["unm"].toString(),
                                    style: new TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)),
                                new Text("Address : " + data[index]["address"],
                                    style: new TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)),
                              ],
                            ),
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                new Text(
                                    "Quantity : " +
                                        data[index]["qty"].toString(),
                                    style: new TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)),
                                new Text("Type : " + data[index]["type"],
                                    style: new TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)),
                              ],
                            ),
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[],
                            ),
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                new Text(
                                    "Mode : " + data[index]["status"] + " ",
                                    style: new TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    // Respond to button press
                                    var idd = (data[index]["id"]).toString();
                                    Assign_or.oid = idd;
                                    print(Assign_or.oid);
                                    update();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.blue,
                                  ),
                                  icon: Icon(Icons.delivery_dining, size: 26),
                                  label: Text("Assign Delivery.."),
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
