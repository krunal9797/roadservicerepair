import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VendorGoogleMapController extends GetxController {
  final LatLng initialPosition = const LatLng(23.237560, 72.647781);
  var markers = <Marker>{}.obs;
  var polylines = <Polyline>{}.obs;
  var isLoading = false.obs;
  LatLng? currentPosition;
  GoogleMapController? _googleMapController;
  Timer? _timer;
  late SharedPreferences prefs;

  void setMapController(GoogleMapController controller) {
    _googleMapController = controller;
    getCurrentLocation();
  }

  @override
  void onInit() {
    super.onInit();
    fetchVendorLocations();
    _timer = Timer.periodic(const Duration(seconds: 15), (timer) {
      fetchVendorLocations();
    });
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  Future<void> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) return;
    }

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    currentPosition = LatLng(position.latitude, position.longitude);

    // Move the camera to the current location
    if (_googleMapController != null) {
      _googleMapController!.animateCamera(CameraUpdate.newLatLngZoom(currentPosition!, 15));
    }

    _updateMarkers([]);
  }


  Future<void> fetchVendorLocations() async {
    prefs = await SharedPreferences.getInstance();
    try {
      isLoading.value = true;
      var response = await http.post(
        Uri.parse('https://roadservice.roadservicerepair.com/api/show_map_vendor.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"vendor_email": prefs.getString('email')}),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['status'] == 1) {
          _updateMarkers([data['info']]);
        }
      }
    } catch (e) {
      print("Exception: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void _updateMarkers(List<dynamic> vendors) {
    markers.clear();

    // Add vendor's (current user) location marker
    if (currentPosition != null) {
      markers.add(Marker(
        markerId: const MarkerId("vendor_location"),
        position: currentPosition!,
        infoWindow: const InfoWindow(title: "Your Location"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      ));
    }

    // Add customer marker (from API)
    for (var vendor in vendors) {
      try {
        double lat = double.parse(vendor['lat'].toString());
        double lng = double.parse(vendor['lang'].toString());
        LatLng customerPosition = LatLng(lat, lng);

        markers.add(Marker(
          markerId: MarkerId(vendor['cust_email'].toString()),
          position: customerPosition,
          infoWindow: InfoWindow(
            title: vendor['name'].toString(),
            snippet: "Service: ${vendor['service']} | Price: ${vendor['est_price']}",
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ));

        // Draw route from vendor to customer
        if (currentPosition != null) {
          fetchRoute(currentPosition!, customerPosition);
        }
      } catch (e) {
        print("Error parsing customer location: $e");
      }
    }

    update(); // Notify UI about marker updates
  }



  Future<void> fetchRoute(LatLng start, LatLng end) async {
    final String apiKey = "AIzaSyDUG0tIfUpSFYsa1fDhcvmnmHYxjkDGm_g";
    final String url = "https://maps.googleapis.com/maps/api/directions/json?origin=${start.latitude},${start.longitude}&destination=${end.latitude},${end.longitude}&key=$apiKey";

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if ((data["routes"] as List).isNotEmpty) {
          _drawRoute(data["routes"][0]["overview_polyline"]["points"]);
        }
      }
    } catch (e) {
      print("Exception: $e");
    }
  }

  void _drawRoute(String encodedPolyline) {
    polylines.clear();
    List<LatLng> polylineCoordinates = _decodePolyline(encodedPolyline);

    polylines.add(Polyline(
      polylineId: const PolylineId("route"),
      color: Colors.blue,
      width: 5,
      points: polylineCoordinates,
    ));


    update();
  }

  List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> polylinePoints = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int shift = 0, result = 0;
      int byte;
      do {
        byte = encoded.codeUnitAt(index++) - 63;
        result |= (byte & 0x1F) << shift;
        shift += 5;
      } while (byte >= 0x20);
      int deltaLat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += deltaLat;

      shift = 0;
      result = 0;
      do {
        byte = encoded.codeUnitAt(index++) - 63;
        result |= (byte & 0x1F) << shift;
        shift += 5;
      } while (byte >= 0x20);
      int deltaLng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += deltaLng;

      polylinePoints.add(LatLng(lat / 1E5, lng / 1E5));
    }

    return polylinePoints;
  }
}
