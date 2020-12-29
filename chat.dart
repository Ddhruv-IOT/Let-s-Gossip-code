import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'login.dart';
import 'register.dart';

class Mychat extends StatefulWidget {
  @override
  _MychatState createState() => _MychatState();
}

class _MychatState extends State<Mychat> {
  String chatmsg;
  var fs = FirebaseFirestore.instance;
  var authc = FirebaseAuth.instance;
  var msgTextController = TextEditingController();
  String msg;

  @override
  Widget build(BuildContext context) {
    var user = authc.currentUser.email;
    var devicewidth = MediaQuery.of(context).size.width;
    var deviceheight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconTheme(
            data: IconThemeData(color: Colors.lime),
            child: IconButton(
              icon: Icon(Icons.location_on),
              onPressed: () {
                Navigator.pushNamed(context, "location");
              },
            ),
          ),
          IconTheme(
            data: IconThemeData(color: Colors.lime),
            child: IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                authc.signOut();
                SystemNavigator.pop();
              },
            ),
          ),
        ],
        title: Text('CHATTING'),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blue,
                  Colors.purple[400],
                ],
                stops: [
                  0.14,
                  0.88,
                ],
              ),
            ),
            height: double.infinity,
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: deviceheight * 0.80,
                      child: StreamBuilder<QuerySnapshot>(
                        stream:
                            fs.collection("chats").orderBy("time").snapshots(),
                        builder: (context, snapshot) {
                          print('new data coming');
                          var msg = snapshot.data.docs;
                          List<Container> y = [];
                          for (var d in msg) {
                            var msgSender = d.data()['sender'];
                            var msgText = d.data()['text'];
                            if (email == msgSender || email1 == msgSender) {
                              msgSender = "You";
                            }
                            var msgWidget = Container(
                              width: double.infinity,
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("$msgSender : $msgText"),
                                ),
                              ),
                            );
                            y.add(msgWidget);
                          }
                          print(y);
                          return Container(
                            child: SingleChildScrollView(
                              reverse: true,
                              child: Column(
                                children: y,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Card(
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: devicewidth * 0.60,
                            child: TextField(
                              decoration: InputDecoration(
                                  hintText: "Enter your message..."),
                              style: TextStyle(color: Colors.red),
                              controller: msgTextController,
                              onChanged: (value) {
                                chatmsg = value;
                              },
                            ),
                          ),
                          Container(
                            width: devicewidth * 0.30,
                            child: FlatButton(
                              onPressed: () async {
                                msgTextController.clear();
                                await fs.collection("chats").add(
                                  {
                                    "text": chatmsg,
                                    "sender": user,
                                    "time": DateTime.now(),
                                  },
                                );
                              },
                              child: Text(
                                "Send",
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
