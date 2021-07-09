import 'dart:convert';

import 'package:digital_ordering/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Order_status extends StatefulWidget {
  const Order_status({Key? key}) : super(key: key);

  @override
  _Order_statusState createState() => _Order_statusState();

  static var oid;
}

class _Order_statusState extends State<Order_status> {
  late List data;

  void List_function() async {
    var url = Uri.parse("$nodeURL/h_order1/");
    Response resp1 = await post(url, body: {"fid": "Dine_in"});
    print(resp1.body);
    data = jsonDecode(resp1.body);

    this.setState(() {});
  }

  void update() async {
    var url = Uri.parse("$nodeURL/update_order/");
    var mid = (Order_status.oid).toString();
    Response resp = await post(url, body: {"oid": mid});
    print(resp.body);

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Order Apprved...")));
    List_function();
  }

  @override
  Widget build(BuildContext context) {
    List_function();
    return Scaffold(
      appBar: AppBar(
        title: Text('Dine-in Order'),
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
                                    "Amount : " +
                                        data[index]["t_amt"].toString(),
                                    style: new TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)),
                                new Text("Date : " + data[index]["date"],
                                    style: new TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)),
                              ],
                            ),
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                ElevatedButton.icon(
                                  onPressed: () {
                                    // Respond to button press
                                    var idd = (data[index]["id"]).toString();
                                    Order_status.oid = idd;
                                    print(Order_status.oid);
                                    update();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.pinkAccent,
                                  ),
                                  icon: Icon(Icons.done, size: 26),
                                  label: Text("Approve"),
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
