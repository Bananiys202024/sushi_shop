//import 'package:flutter/material.dart';
//import 'package:geolocation/geolocation.dart';
//import 'package:flutter_map/flutter_map.dart';
//import 'package:latlong/latlong.dart';
//
//
//class GeoLocator extends StatefulWidget {
//  GeoLocator({Key key}) : super(key: key);
//
//  @override
//  _GeoLocatorState createState() => _GeoLocatorState();
//}
//
//class _GeoLocatorState extends State<GeoLocator> {
//
//  MapController _controller = new MapController();
//
//  getPermission() async {
//    final GeolocationResult result = await Geolocation
//        .requestLocationPermission(
//        const LocationPermission(
//            android: LocationPermissionAndroid.fine,
//            ios: LocationPermissionIOS.always));
//
//    return result;
//  }
//
//  getLocation() {
//    return getPermission().then((result) async {
//      if (result.isSuccessful) {
//        final coords = await Geolocation.currentLocation(
//            accuracy: LocationAccuracy.best);
//      return coords;
//      }
//      return null;
//    });
//  }
//
//  buildMap() {
//    getLocation().then((response) {
//      if (response.isSuccessful) {
//        response.listen((value) {
//
//          debugPrint("Value location latitude---"+ value.location.latitude);
//          debugPrint("Value location longtitude---"+value.location.longtitude.toString());
//
//
//          _controller.move(
//             new LatLng(value.location.latitude, value.location.longtitude),
//              15.0);
//        });
//      }
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: new AppBar(
//          title: new Text('Geolocation'),
//      ),
//      body: new FlutterMap(
//        mapController: _controller,
//        options: new MapOptions(center: buildMap(), minZoom: 0.0),
//        layers: [
//          new TileLayerOptions(
//              urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
//              subdomains: ['a', 'b', 'c']),
//
//        ],
//      ),
//    );
//  }
//}
