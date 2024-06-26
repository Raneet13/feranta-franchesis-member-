import 'dart:io';

import 'package:dio/dio.dart';
import 'package:feranta_franchise/repository/profile/profile_repo.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/profile/view_profileDetails.dart';
import '../../static/flutter_toast_message/toast_messge.dart';

class MapViewModelProvider extends ChangeNotifier {
  bool isLoading = false;
  late LocationPermission permission;
  isLoadingTrue() {
    isLoading = true;
    notifyListeners();
  }

  isLoadingFalse() {
    isLoading = false;
    notifyListeners();
  }

  Future locationPermissionRequest() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return await Geolocator.isLocationServiceEnabled();
      // return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
  }

  // Test if location services are enabled.
  Future<Position> checkCurrentLocation() async {
    await locationPermissionRequest();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return position;
  }
}
