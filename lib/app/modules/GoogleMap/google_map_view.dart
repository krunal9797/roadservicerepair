import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:roadservicerepair/app/modules/GoogleMap/google_map_controller.dart';

class GoogleMapView extends StatelessWidget {
  const GoogleMapView({super.key});

  @override
  Widget build(BuildContext context) {
    final MapController mapController = Get.put(MapController());

    return Scaffold(
      body: GetBuilder<MapController>(
        builder: (controller) {
          return Stack(
            children: [
              GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: controller.initialPosition,
                  zoom: 12.0,
                ),
                markers: controller.markers,
                polylines: controller.polylines,
                onMapCreated: (GoogleMapController mapController) {
                  controller.setMapController(mapController);
                },
              ),
              if (controller.isLoading.value)
                const Center(child: CircularProgressIndicator()),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await mapController.getCurrentLocation(); // First, update the current location
          mapController.fetchVendorLocations(); // Then, fetch vendor locations
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
