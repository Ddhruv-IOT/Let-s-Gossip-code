import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login.dart';
import 'register.dart';

var longitude;
var latitude;
var locat;
var authc = FirebaseAuth.instance;
var user = authc.currentUser.email;

class Gmaps extends StatefulWidget {
  @override
  GmapsState createState() => GmapsState();
}

class GmapsState extends State<Gmaps> {
  String chatmsg;
  var fs = FirebaseFirestore.instance;

  var msgTextController = TextEditingController();
  String msg;
  getLocation() async {
    var oldloc;
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    debugPrint('location: ${position.latitude}');
    debugPrint('location: ${position.longitude}');
    print('location: ${position.latitude}');
    print('location: ${position.longitude}');
    longitude = position.longitude;
    latitude = position.latitude;
    final coordinates = new Coordinates(position.latitude, position.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    setState(() {
      locat = "${first.featureName} : ${first.addressLine}";
      print(locat);
    });
    print("${first.featureName} : ${first.addressLine}");
    if (locat != null && oldloc == null) {
      lot();
      oldloc = locat;
    } else if (locat != null && oldloc != locat) {
      lot();
    }
  }

  lot() async {
    await fs.collection("location").add(
      {
        "location1": locat,
        "sender": user,
        "time": DateTime.now(),
        "timestamp":
            "${DateTime.now().hour}:${DateTime.now().minute} on ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
        "lat": latitude,
        "lon": longitude,
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    var deviceheight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('LOCATION'),
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
                        stream: fs
                            .collection("location")
                            .orderBy("time")
                            .snapshots(),
                        builder: (context, snapshot) {
                          print('new data coming');
                          var msg = snapshot.data.docs;
                          List<Container> y = [];
                          for (var d in msg) {
                            var msgSender = d.data()['sender'];
                            var msgText = d.data()['location1'];
                            var times = d.data()['timestamp'];
                            var lat1 = d.data()['lat'];
                            var lon1 = d.data()['lon'];
                            if (email == msgSender || email1 == msgSender) {
                              continue;
                            } else {
                              var msgWidget = Container(
                                width: double.infinity,
                                child: Card(
                                  child: Column(
                                    children: <Widget>[
                                      /*child:*/ Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                            "Pesron Id: $msgSender \nLocation: $msgText \nTime: $times"),
                                      ),
                                      FlatButton(
                                        hoverColor: Colors.red,
                                        highlightColor: Colors.red,
                                        onPressed: () {
                                          Navigator.pushNamed(
                                            context,
                                            "maps",
                                            arguments: {
                                              "latt": lat1,
                                              "long": lon1
                                            },
                                          );
                                        },
                                        child: Text("LOCATE "),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                              y.add(msgWidget);
                            }
                          }
                          print(y);
                          return Container(
                            child: SingleChildScrollView(
                              // reverse: true,
                              child: Column(
                                children: y,
                              ),
                            ),
                          );
                        },
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
