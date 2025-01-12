import 'package:location/location.dart';

// 位置情報製造機
class Geolocator {

  static Future<LocationData> getPosition() async {
    final currentLocation = await Location().getLocation();
    return currentLocation;
  }
}
