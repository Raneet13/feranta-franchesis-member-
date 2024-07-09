import 'dart:io';

import 'package:dio/dio.dart';
import 'package:feranta_franchise/repository/profile/profile_repo.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../configs/imageCompress_function.dart';
import '../../model/profile/view_profileDetails.dart';
import '../../static/flutter_toast_message/toast_messge.dart';

class ProfileViewmodel extends ChangeNotifier {
  File? profileImage;
  var profileImageName = '';
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  bool isLoading = false;
  ProfileDetailsModel? profileDetailsModel;
  // MyprofileDetaisModel? myprofileDetaisModel;
  Future insertProfileImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png'],
    );

    if (result != null) {
      var compressImage =
          await compressFile(file: File(result.files.single.path!));
      File file = File(compressImage!.path);

      profileImage = file;
    } else {
      // print(result);
      // User canceled the picker
    }
    notifyListeners();
  }

  Future viewProfiledetails() async {
    isLoadingTrue();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = await prefs.getString('userId');
    var allData = await ProfileRepository().viewProfie(member_id: userId);
    if (allData["error"] == null) {
      profileDetailsModel = ProfileDetailsModel.fromJson(allData);
      nameController.text =
          profileDetailsModel!.response!.userDetails!.fullName ?? "";
      emailController.text =
          profileDetailsModel!.response!.userDetails!.email ?? "";
      phoneController.text =
          profileDetailsModel!.response!.userDetails!.contactNo ?? "";
    } else {
      ShowToast(msg: "Wrong to fetch profile Data");
    }
    isLoadingFalse();
    notifyListeners();
  }

  profileImageNameUpdate() {
    if (profileImage != null) {
      List<String> parts = profileImage!.path.split('/');

      // Get the text after the last "/"
      profileImageName = parts.last;
    }

    notifyListeners();
  }

  Future updateProfileViewmodel() async {
    isLoadingTrue();
    // profileImageNameUpdate();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = await prefs.getString('userId');

    var allData = await ProfileRepository().updateProfie(
        customer_id: userId,
        name: nameController.text.toString(),
        email: emailController.text.toString(),
        contact_no: phoneController.text.toString(),
        image: profileImage != null
            ? await MultipartFile.fromFile(profileImage!.path,
                filename: profileImage!.path.split('/').last)
            : "");

    if (allData["error"] != null) {
      ShowToast(msg: allData["response"]["message"].toString());
    } else {
      ShowToast(msg: "Profile Update Sucessfully");

      viewProfiledetails();
    }

    isLoadingFalse();
    notifyListeners();
  }

  isLoadingTrue() {
    isLoading = true;
    notifyListeners();
  }

  isLoadingFalse() {
    isLoading = false;
    notifyListeners();
  }
}
