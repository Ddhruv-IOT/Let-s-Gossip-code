import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Myhome extends StatefulWidget {
  @override
  _MyhomeState createState() => _MyhomeState();
}

class _MyhomeState extends State<Myhome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "LeTs GoSsIp ....",
          style: TextStyle(
            color: Colors.lime,
          ),
        ),
        backgroundColor: Colors.black,
        actions: <Widget>[
          IconTheme(
            data: IconThemeData(color: Colors.lime),
            child: IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                SystemNavigator.pop();
              },
            ),
          ),
        ],
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Material(
                  elevation: 10,
                  borderRadius: BorderRadius.circular(400),
                  color: Colors.blue[900],
                  child: MaterialButton(
                    height: 20,
                    minWidth: 150,
                    child: Text(
                      'LOGIN',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.lime),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, "login");
                    },
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: Material(
                    elevation: 10,
                    borderRadius: BorderRadius.circular(400),
                    color: Colors.blue[900],
                    child: MaterialButton(
                      height: 20,
                      minWidth: 150,
                      child: Text(
                        'REGISTER',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.lime,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, "reg");
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
