import 'dart:convert';

import 'package:chat_shop/src/core/result/result_domain.dart';
import 'package:chat_shop/src/features/cart/data/location_dto.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class LocationService {
  Future<LongLang> fetcher() async {
    await Geolocator.requestPermission();
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      await Geolocator.openLocationSettings();
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    return LongLang(position.longitude, position.latitude);
  }

  Future<Result<LongLang>> location() async {
    int attemp = 0;
    int totatl = 3;
    while (attemp < totatl) {
      try {
        final result = await fetcher();

        if (result.lat != null) {
          return Result.onSuccess(result);
        }
      // ignore: empty_catches
      } catch (e) {
       
      }

      await Future.delayed(const Duration(seconds: 4));
      attemp++;
    }
    return Result.onfailure('Please turn on your device location setting, or you can cancel and use your default address.');
  }

  Future<Result<String>> locationDecoder(LongLang longLang) async {
    try {
      final apikey = 'pk.b43c18cb29d3ee72d3abe5cf215885f8';

      final url =
          'https://us1.locationiq.com/v1/reverse?key=$apikey&lat=${longLang.lat}&lon=${longLang.long}&format=json&';
      final result = await http.get(Uri.parse(url));
      if (result.statusCode == 200) {
        final json = jsonDecode(result.body);
        return Result.onSuccess(Place.fromJson(json).address);
      }

      return Result.onfailure('Error in decoder Api');
    } catch (e) {
      
      return Result.onfailure(e.toString());
    }
  }
}

class LongLang {
  final double? long;
  final double? lat;
  LongLang(this.long, this.lat);
}
