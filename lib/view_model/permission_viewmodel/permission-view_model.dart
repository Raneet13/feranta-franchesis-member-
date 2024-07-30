import 'dart:async';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionViewModel extends ChangeNotifier {
  bool cameraPermission = false;
  bool locationPermission = false;
  bool photoPermissioon = false;
  bool backgroundActivity = false;
  bool notificationAllowuser = false;
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  Future<void> requestCameraPermission() async {
    var status = await Permission.camera.status;
    if (status.isDenied) {
      if (await Permission.camera.request().isGranted) {
        // Permission granted
        // _initializeCamera();
        cameraPermission = true;
      }
    } else if (status.isGranted) {
      // Permission already granted
      // _initializeCamera();
      cameraPermission = true;
    } else if (status.isPermanentlyDenied) {
      // Permission permanently denied, handle appropriately
      openAppSettings();
    }
    notifyListeners();
  }

  Future<void> requestlocationPermission() async {
    var locationPer = await Permission.location.request();
    if (locationPer.isGranted) {
      locationPermission = true;
    } else if (locationPer.isDenied) {
      locationPer;
    } else if (locationPer.isPermanentlyDenied) await openAppSettings();
    notifyListeners();
  }

  Future<void> _requestGalleryPermission() async {
    await Permission.photos.request();
    var status = await Permission.photos.status;

    if (status.isDenied) {
      await Permission.photos.request();
    } else if (status.isGranted) {
      photoPermissioon = true;
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
    notifyListeners();
  }

  Future permissionPhotoOrStorage() async {
    late bool perm = false;
    if (Platform.isIOS) {
      perm = await permissionPhotos();
    } else if (Platform.isAndroid) {
      final AndroidDeviceInfo android = await DeviceInfoPlugin().androidInfo;
      final int sdkInt = android.version.sdkInt ?? 0;
      perm = sdkInt > 32 ? await permissionPhotos() : await permissionStorage();
    } else {}
    notifyListeners();
  }

  Future permissionPhotos() async {
    print("Permission photos");
    await Permission.photos.request();
    var status = await Permission.photos.status;

    if (status.isDenied) {
      await Permission.photos.request();
    } else if (status.isGranted) {
      photoPermissioon = true;
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
    notifyListeners();
  }

  Future permissionStorage() async {
    print("Permisssion storage");

    await Permission.storage.request();
    var status = await Permission.storage.status;

    if (status.isDenied) {
      await Permission.storage.request();
    } else if (status.isGranted) {
      photoPermissioon = true;
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
    notifyListeners();
  }

  Future<void> requestBackgroundActivityPermission() async {
    final status = await Permission.ignoreBatteryOptimizations.request();
    if (status.isGranted) {
      backgroundActivity = true;
    } else if (status.isDenied) {
    } else if (status.isPermanentlyDenied) {
      // Permission permanently denied
      openAppSettings();
    }
    notifyListeners();
  }

  Future<void> allowNotificationUser() async {
    final status = await Permission.notification.request();
    if (status.isGranted) {
      notificationAllowuser = true;
    } else if (status.isDenied) {
      status;
    } else if (status.isPermanentlyDenied) {
      // Permission permanently denied
      openAppSettings();
    }
    notifyListeners();
  }
}
