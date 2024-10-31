import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import '../Widgets/custom_toast.dart';

class LocationService {
  Future<Position> requestLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      await Geolocator.openAppSettings();
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<List<String>> getAddress() async {
    String address = '';
    var access = await requestLocationPermission();
    try {
      List<Placemark> placeMark =
          await placemarkFromCoordinates(access.latitude, access.longitude);
      if (placeMark.isNotEmpty) {
        Placemark placemark = placeMark.first;
        address = placemark.locality ?? 'Unable to get location';
        // address = removeSpecialCharacters(address);
      }
      return [access.latitude.toString(), access.longitude.toString(), address];
    } catch (e) {
      showToast("Please, Enable device location permissions.");
    }
    return [];
  }

  // String removeSpecialCharacters(String address) {
  //   // Regular expression to match special characters
  //   RegExp specialCharRegex = RegExp(r'[^\w\s,]');
  //
  //   // Replace special characters with an empty string
  //   return address.replaceAll(specialCharRegex, '');
  // }
}
