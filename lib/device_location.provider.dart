import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

final deviceLocationProvider = FutureProvider<LatLng>((ref) async {
  Location location = Location();

// On vérifie que le service de location est activé sur le téléphone
  bool serviceEnabled = await location.serviceEnabled();
  if (!serviceEnabled) {
    serviceEnabled = await location.requestService();
    if (!serviceEnabled) {
      return Future.error("service_not_enabled");
    }
  }

// On vérifie que l'utilisateur a donné son autorisation
  PermissionStatus permissionGranted = await location.hasPermission();
  if (permissionGranted == PermissionStatus.denied) {
    permissionGranted = await location.requestPermission();
    if (permissionGranted != PermissionStatus.granted) {
      return Future.error("Permission_not_granted");
    }
  }

  final LocationData locationData = await location.getLocation();

  return Future.value(LatLng(locationData.latitude!, locationData.longitude!));
});
