import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

String email1;

class MyReg extends StatefulWidget {
  @override
  MyRegState createState() => MyRegState();
}

class MyRegState extends State<MyReg> {
  var authc = FirebaseAuth.instance;

  String password;
  var x;

  account() async {
    try {
      var user = await authc.createUserWithEmailAndPassword(
          email: email1, password: password);

      print(user);
      if (user != null) {
        setState(() {
          x = "Done you are registered now";
          var ipd = authc.currentUser.uid;
          print("**********$ipd**************");
        });
        await Future.delayed(Duration(seconds: 3), () {
          Navigator.pushNamed(context, "chat");
        });
      }
    } catch (e) {
      print("exception case *******$e**********");
      setState(() {
        x = e;
      });
    }
    return x;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Registration',
          style: TextStyle(color: Colors.lime),
        ),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.lime),
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
                end: Alignment.topRight,
              ),
            ),
            child: Center(
              child: Container(
                height: 250,
                width: 300,
                child: SingleChildScrollView(
                  child: Center(
                    child: Card(
                      color: Colors.blue[900],
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: TextField(
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 21),
                              textAlign: TextAlign.center,
                              onChanged: (value) {
                                email1 = value;
                              },
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Enter email address',
                                hintStyle: TextStyle(
                                  fontSize: 21.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            color: Colors.lime,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Card(
                            color: Colors.lime,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: TextField(
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 21),
                              textAlign: TextAlign.center,
                              obscureText: true,
                              onChanged: (value) {
                                password = value;
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Enter Your password',
                                hintStyle: TextStyle(
                                  fontSize: 21.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Builder(
                            builder: (BuildContext context) => Material(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(12),
                              child: MaterialButton(
                                onPressed: () {
                                  account();
                                  Future.delayed(
                                    Duration(seconds: 1),
                                    () {
                                      Scaffold.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('*******$x**********'),
                                          duration: Duration(seconds: 3),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Text(
                                  'Sign up',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
