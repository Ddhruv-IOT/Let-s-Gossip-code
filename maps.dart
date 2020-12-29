import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import "package:latlong/latlong.dart" as latLng;
import 'location.dart';

var lat = latitude;
var lon = longitude;
var latf;
var lonf;

class Maps extends StatefulWidget {
  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  MapController _mapController;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
  }

  @override
  Widget build(BuildContext context) {
    Map x = ModalRoute.of(context).settings.arguments;
    latf = x['latt'];
    lonf = x['long'];
    print("==================data==========================\n $latf \n $lonf");
    var r = 0.0;
    var points = <latLng.LatLng>[
      latLng.LatLng(lat, lon),
      latLng.LatLng(latf, lonf),
    ];

    var mapOptions = new MapOptions(
      center: latLng.LatLng(latf, lonf),
      zoom: 5,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Location Map"),
      ),
      body: new FlutterMap(
        mapController: _mapController,
        options: mapOptions,
        layers: [
          new TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c']),
          new PolylineLayerOptions(
            polylines: [
              Polyline(
                points: points,
                color: Colors.red,
                strokeWidth: 4.5,
              )
            ],
          ),
          new MarkerLayerOptions(
            markers: [
              new Marker(
                width: 80.0,
                height: 80.0,
                point: latLng.LatLng(lat, lon),
                builder: (ctx) =>
                    new Container(child: new Image.asset("assets/me.png")),
              ),
              new Marker(
                width: 80.0,
                height: 80.0,
                point: latLng.LatLng(latf, lonf),
                builder: (ctx) => new Container(
                  child: new Image.asset("assets/other.png"), //FlutterLogo(),
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.my_location),
              tooltip: ("Your Location"),
              onPressed: () {
                _mapController.move(latLng.LatLng(lat, lon), 17);
              },
            ),
            IconButton(
              icon: Icon(Icons.group),
              tooltip: ("Friends Location"),
              onPressed: () {
                _mapController.move(latLng.LatLng(latf, lonf), 17);
              },
            ),
            IconButton(
              icon: Icon(Icons.zoom_in),
              tooltip: ("Zoom In"),
              onPressed: () {
                var newZoom = _mapController.zoom + 1;
                _mapController.move(_mapController.center, newZoom);
              },
            ),
            IconButton(
              icon: Icon(Icons.zoom_out),
              tooltip: ("Zoom Out"),
              onPressed: () {
                var newZoom = _mapController.zoom - 1;
                _mapController.move(_mapController.center, newZoom);
              },
            ),
            IconButton(
              icon: Icon(Icons.restore_page),
              tooltip: ("Recenter"),
              onPressed: () {
                _mapController.move(_mapController.center, 4);
              },
            ),
            IconButton(
              icon: Icon(Icons.filter_tilt_shift),
              tooltip: ("Shrink View"),
              onPressed: () {
                _mapController.fitBounds(LatLngBounds.fromPoints(points));
              },
            ),
            IconButton(
              icon: Icon(Icons.rotate_90_degrees_ccw),
              tooltip: ("Rotate by 90 degrees"),
              onPressed: () {
                _mapController.rotate(r);
                _mapController.move(_mapController.center, 4);
                r = r + 90.0;
              },
            ),
          ],
        ),
      ),
    );
  }
}
