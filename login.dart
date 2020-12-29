import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

String email;

class MyLogin extends StatefulWidget {
  @override
  MyLoginState createState() => MyLoginState();
}

class MyLoginState extends State<MyLogin> {
  var authc = FirebaseAuth.instance;

  String password;
  var stop;

  // ignore: unused_field
  bool _initialized = false;
  // ignore: unused_field
  bool _error = false;
  // Define an async function to initialize FlutterFire

  void initializeFlutterFire() async {
    try {
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      setState(() {
        _error = true;
      });
    }
  }

  login() async {
    print(email);
    print(password);
    try {
      var signIn = await authc.signInWithEmailAndPassword(
          email: email, password: password);
      print(signIn);

      if (signIn != null) {
        setState(() {
          stop = "Signin successful!";
        });
        await Future.delayed(Duration(seconds: 4), () {
          Navigator.pushNamed(context, "chat");
        });
      } else {
        print("signin ");
        setState(() {
          stop = "Signin Failed!";
        });
      }
    } catch (e) {
      setState(() {
        stop = e;
        print(stop);
      });
      print("**************exception:$e******************");
    }
    if (stop.toString() ==
        "[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.") {
      await Future.delayed(Duration(seconds: 5), () {
        Navigator.pushNamed(context, "reg");
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.lime),
        title: Text(
          'Login',
          style: TextStyle(color: Colors.lime),
        ),
      ),
      body: Stack(
        children: [
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
            child: Center(
              child: Container(
                height: 250,
                width: 300,
                child: SingleChildScrollView(
                  child: Card(
                    color: Colors.purple[900],
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
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
                            onChanged: (value) {
                              email = value;
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
                                login();
                                Future.delayed(Duration(seconds: 3), () {
                                  Scaffold.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('*******$stop**********'),
                                      duration: Duration(seconds: 3),
                                    ),
                                  );
                                });
                              },
                              child: Text(
                                'Sign in',
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
        ],
      ),
    );
  }
}
