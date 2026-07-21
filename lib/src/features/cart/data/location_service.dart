import 'dart:convert';
import 'dart:io';

import 'package:chat_shop/src/core/result/result_domain.dart';
import 'package:flutter/foundation.dart';
import 'package:chat_shop/src/features/cart/data/location_dto.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class LocationService {
  Future<Result<String?>> fetcher() async {
    try {
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
        final apikey = 'pk.b43c18cb29d3ee72d3abe5cf215885f8';
        final decodinngUrl =
            'https://us1.locationiq.com/v1/reverse?key=$apikey&lat=${position.latitude}&lon=${position.longitude}&format=json&';
        final response = await http.get(Uri.parse(decodinngUrl));
        final data = jsonDecode(response.body);
        final place = Place.fromJson(data);

        return Result.onSuccess(place.address);
      }
    } catch (e) {
      return Result.onfailure(e.toString());
    }

    return Result.onSuccess(null);
  }
}
