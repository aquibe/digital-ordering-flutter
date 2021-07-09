import 'package:digital_ordering/constants.dart';
import 'package:digital_ordering/layouts/ad_home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Adcomplntreply extends StatefulWidget {
  const Adcomplntreply({Key? key}) : super(key: key);

  @override
  _AdcomplntreplyState createState() => _AdcomplntreplyState();
  static var cid;
}

class _AdcomplntreplyState extends State<Adcomplntreply> {
  late TextEditingController fd;

  @override
  void initState() {
    // TODO: implement initState
    fd = TextEditingController();
    super.initState();
  }

  void post_rply() async {
    var url = Uri.parse("$nodeURL/a_update_reply/");
    var nm = fd.text;

    Response resp = await post(url,
        body: {"rep": nm, "uid": (Adcomplntreply.cid).toString()});
    print(resp.body);

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Reply posted Successful...")));
    Navigator.push(context, MaterialPageRoute(builder: (_) => Adhome()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Post Reply'),
        ),
        // backgroundColor: Colors.grey,
        body: Container(
          decoration: new BoxDecoration(color: Colors.white54),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 60.0),
                  child: Center(),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 140, bottom: 20),
                  //padding: EdgeInsets.symmetric(horizontal: 15),
                  child: TextField(
                    controller: fd,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.text_fields),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        labelText: 'Reply',
                        hintText: 'Enter your reply here'),
                  ),
                ),
                Container(
                  height: 50,
                  width: 320,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(30)),
                  child: ElevatedButton(
                    onPressed: () {
                      // Respond to button press
                      var n1 = fd.text;
                      if (n1 == "") {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Fill all fields......")));
                      } else {
                        post_rply();
                      }
                    },
                    child: Text(
                      'POST',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
