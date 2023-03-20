import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapWidget extends StatefulWidget {
  MapWidget({Key? key, required this.markerLocation}) : super(key: key);
  final LatLng markerLocation;

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  final Completer<GoogleMapController> _controller = Completer();

  BitmapDescriptor? bikeIcon;

  final List<Marker> _markers = [];

  setIcons() async {
    bikeIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(
          size: Size(10, 10),
        ),
        "assets/icons/bike_icon.png");
    //     .then((value) {
    //   bikeIcon = value;
    // });
  }
  setPageData() async {
    await setIcons();
    setState(() {
    _markers.add(
        Marker(
          markerId: MarkerId('1'),
          infoWindow: InfoWindow(title: "Your Current Location"),
          position: widget.markerLocation,
          icon: bikeIcon??BitmapDescriptor.defaultMarker
        ));
    });
  }
  @override
  void initState() {
    setPageData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(target: widget.markerLocation, zoom: 16),
      mapType: MapType.terrain,
      markers: Set<Marker>.of(_markers),
      // zoomGesturesEnabled: false,
      zoomControlsEnabled: true,
      // onCameraMove: _onCameraMove,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    );
  }
}
