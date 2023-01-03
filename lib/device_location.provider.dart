import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

final deviceLocationProvider = FutureProvider<LatLng>((ref) async {
  Location location = Location();

  print('deviceLocationProvider 1');
// On vérifie que le service de location est activé sur le téléphone
  bool serviceEnabled = await location.serviceEnabled();
  if (!serviceEnabled) {
    serviceEnabled = await location.requestService();
    if (!serviceEnabled) {
      return Future.error("service_not_enabled");
    }
  }

  print('deviceLocationProvider 2');

// On vérifie que l'utilisateur a donné son autorisation
  PermissionStatus permissionGranted = await location.hasPermission();
  if (permissionGranted == PermissionStatus.denied) {
    permissionGranted = await location.requestPermission();
    if (permissionGranted != PermissionStatus.granted) {
      return Future.error("Permission_not_granted");
    }
  }

  print('deviceLocationProvider 3');
  final LocationData locationData = await location.getLocation();

  print('current lat:lng : ${locationData.latitude!} : ${locationData.longitude!}');

  return Future.value(LatLng(locationData.latitude!, locationData.longitude!));
});
