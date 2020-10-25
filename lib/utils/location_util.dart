part of 'utils.dart';

/// Declaring utility function for location features.

class LocationUtil {
  static Location _location = Location();

  static Future<bool> isGPSEnabled() async {
    return _location.serviceEnabled();
  }

  static Future<bool> enableGPS() async {
    return await _location.requestService();
  }
}