import 'dart:io';

import 'package:flutter/foundation.dart';

import 'package:flutter_experiments/features/cart/ui/providers/cart_provider.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  String? location;

  Future<String?> fetcher(CartProvider cartprovider) async {
    if (Platform.isAndroid || Platform.isIOS || kIsWeb) {
      bool locationenbled = await Geolocator.isLocationServiceEnabled();
      if (!locationenbled) {
        LocationPermission permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.denied ||
            permission == LocationPermission.deniedForever) {
          await Geolocator.requestPermission();
        }
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      List<Placemark> placemark = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      Placemark place = placemark[0];

      location = '''${place.name},${place.street},${place.subLocality},
    ${place.locality},${place.postalCode},${place.country}''';
    } else if (Platform.isWindows) {
      location;
    }

    return location;
  }
}
